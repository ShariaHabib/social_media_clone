import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clone/common/constants.dart';
import 'package:social_media_clone/common/custom_appbar.dart';
import 'package:social_media_clone/common/custom_button.dart';
import '../common/custom_textfield.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key, this.widget, this.screen}) : super(key: key);
  final Widget? widget;
  final String? screen;
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _email = TextEditingController();

  bool isLoading = false;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> forgotPassword({required String email}) async {
    try {
      print(email);
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      print("Password reset email sent to $email");
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.message}");

      throw e;
    } catch (e) {
      print("Error: $e");
      throw e;
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
                  child: ForgetPasswordBody(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ForgetPasswordBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Reset Password",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
              color: Constants.secondaryColor,
              fontWeight: FontWeight.bold,
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
        SizedBox(
          height: 20,
        ),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomFilledButton(
                onPressed: () async {
                  try {
                    await forgotPassword(email: _email.text);

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          surfaceTintColor: Colors.white,
                          icon: const Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              Positioned(
                                top: -80,
                                child: Icon(
                                  Icons.mark_as_unread_sharp,
                                  size: 100,
                                ),
                              ),
                            ],
                          ),
                          title: const Text(
                            "Password reset link sent",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            "Successful password reset link sent to email:\n\"${_email.text}\"\nplease follow the email password reset instruction",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 9, 67, 115)
                                  .withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          actions: [
                            Container(
                              width: 250,
                              height: 45,
                              child: FilledButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Okay"),
                              ),
                            ),
                          ],
                          actionsAlignment: MainAxisAlignment.center,
                        );
                      },
                    );
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          surfaceTintColor: Colors.white,
                          icon: const Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              Positioned(
                                top: -80,
                                child: Icon(
                                  Icons.error,
                                  size: 100,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          title: const Text(
                            "No user found",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: const Text(
                            "Please type a valid email address which is registered in Showa system",
                          ),
                          actions: [
                            Container(
                              width: 250,
                              height: 45,
                              child: FilledButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Okay"),
                              ),
                            ),
                          ],
                          actionsAlignment: MainAxisAlignment.center,
                        );
                      },
                    );
                  }
                },
                buttonText: "Reset Password",
                buttonTextColor: Colors.white,
                filledColor: Constants.primaryColor,
              ),
      ],
    );
  }
}
