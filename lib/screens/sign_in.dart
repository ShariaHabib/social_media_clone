import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_clone/common/constants.dart';
import 'package:social_media_clone/common/custom_appbar.dart';
import 'package:social_media_clone/common/custom_button.dart';
import 'package:social_media_clone/controller/signInGoogle.dart';
import '../common/custom_textfield.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key, this.widget, this.screen}) : super(key: key);
  final Widget? widget;
  final String? screen;
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isChecked = false;
  bool isLoading = false;
  Future<void> signInWithEmailPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      final creds = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      String uid = creds.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'email': _email.text,
      });
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password provided for that user'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }

  Future<void> signInWithGoogle() async {
    var user = await SignInGoogle.signInWithGoogle();
    if (user != null) {
      print("Sign in successful");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign in failed"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.network(
            Constants.backgroundImage,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.25,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
              child: Container(
                color: Colors.white.withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: signInBody(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              color: Constants.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            "Enter your details below",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              color: Constants.secondaryColor,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Email Address",
          style: TextStyle(
            fontSize: Constants.fontSmall,
            color: Constants.secondaryColor,
          ),
        ),
        CustomTextField(
          editingController: _email,
          hintText: "Enter your email address",
        ),
        const SizedBox(height: 20),
        const Text(
          "Password",
          style: TextStyle(
            fontSize: Constants.fontSmall,
            color: Constants.secondaryColor,
          ),
        ),
        CustomTextField(
          editingController: _password,
          hintText: "Enter your password",
          isSecure: true,
        ),
        const SizedBox(height: 20),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomFilledButton(
                onPressed: () async {
                  try {
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      final vsss = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: _email.text,
                        password: _password.text,
                      );

                      Navigator.pushNamed(context, '/dashboard',
                          arguments: vsss.user!.uid);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        Fluttertoast.showToast(
                            msg: 'No user found for that email.');
                      } else if (e.code == 'invalid-credential') {
                        Fluttertoast.showToast(
                            msg: 'Wrong username or password');
                      } else {
                        Fluttertoast.showToast(msg: 'Eorror!');
                      }
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                      ),
                    );
                  }
                },
                buttonText: "SIGN IN",
                buttonTextColor: Colors.white,
                filledColor: Constants.primaryColor,
              ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                  activeColor: Constants.primaryColor,
                ),
                Text("Remember me"),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgetpassword');
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Constants.secondaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: signInWithGoogle,
            child: Text(
              "Sign in with Google",
              style: TextStyle(color: Constants.secondaryColor),
            ),
          ),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account?",
              style: TextStyle(
                fontSize: Constants.fontMedium,
                color: Constants.secondaryColor,
              ),
            ),
            SizedBox(width: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Constants.primaryColor),
              ),
              child: const Text(
                "SIGN UP",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
