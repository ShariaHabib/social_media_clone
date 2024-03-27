import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media_clone/common/constants.dart';
import 'package:social_media_clone/common/custom_appbar.dart';
import 'package:social_media_clone/common/custom_button.dart';
import 'package:social_media_clone/common/custom_textfield.dart';
import 'package:social_media_clone/controller/auth.dart';

@override
class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isSelected = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Password cannot be empty";
    } else if (value.length < 8) {
      RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8,}$');
      if (!regex.hasMatch(value)) {
        return "Use 8 or more characters with a mix of letters, numbers & symbols";
      }
      return "Password must be at least 8 characters";
    }
  }

  String? confirmPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return "Confirm Password cannot be empty";
    } else if (passwordValidator(value) != "") {
      return passwordValidator(value);
    } else if (value != _password.text) {
      return "Password does not match";
    }
  }

  bool _isLoading = false;
  Future<void> firebaseRegister() async {
    setState(() {
      _isLoading = true;
    });
    User? user = await AuthController.signUpWithEmailPassword(
      _email.text,
      _password.text,
    );
    if (user != null) {
      print('Signed up user: ${user.uid}');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Constants.signUpText,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  color: Constants.secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  Constants.signUpText2,
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
                    color: Constants.secondaryColor),
              ),
              CustomTextField(
                editingController: _email,
                hintText: Constants.hintEmail,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!value.contains("@")) {
                    return "Email is invalid";
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Password",
                style: TextStyle(
                    fontSize: Constants.fontSmall,
                    color: Constants.secondaryColor),
              ),
              CustomTextField(
                editingController: _password,
                hintText: Constants.hintPassword,
                isSecure: true,
                obscureText: true,
                validator: passwordValidator,
              ),
              const SizedBox(height: 20),
              const Text(
                "Confirm Password",
                style: TextStyle(
                    fontSize: Constants.fontSmall,
                    color: Constants.secondaryColor),
              ),
              CustomTextField(
                editingController: _confirmPassword,
                hintText: Constants.hintConfirmPassword,
                isSecure: true,
                obscureText: true,
                validator: confirmPasswordValidator,
              ),
              const SizedBox(height: 20),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Checkbox(
                        value: isSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            isSelected = value!;
                          });
                        },
                      ),
                      const Text("Read our ",
                          style: TextStyle(color: Constants.secondaryColor)),
                      GestureDetector(
                        onTap: () {},
                        child: const Text("Privacy Policy",
                            style: TextStyle(color: Color(0xff1E6D8B))),
                      ),
                      const Text(
                        ". Tap \"Agree ",
                        style: TextStyle(
                          color: Constants.secondaryColor,
                        ),
                      ),
                      const Text(
                        "and continue\" to accept the",
                        style: TextStyle(
                          color: Constants.secondaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Terms of Service",
                          style: TextStyle(color: Color(0xff1E6D8B)),
                        ),
                      ),
                      const Text(".",
                          style: TextStyle(color: Constants.secondaryColor))
                    ],
                  ),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomFilledButton(
                          onPressed: isSelected
                              ? () {
                                  try {
                                    if (formKey.currentState!.validate()) {
                                      firebaseRegister();
                                      Navigator.pushNamed(context, "/signin");
                                    }
                                  } on Exception catch (e) {
                                    print(e);
                                  }
                                }
                              : null,
                          buttonText: Constants.registerButton,
                          filledColor: Constants.primaryColor,
                          buttonTextColor: Colors.white,
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
