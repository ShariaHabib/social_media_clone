import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthController {
  static Future<User?> signUpWithEmailPassword(
      String email, String password) async {
    print("Called with $email and $password");
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('users').add({
        'email': email,
        'password': password,
      });
      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Email already in use');
      } else {
        Fluttertoast.showToast(msg: 'Error: $e');
      }
    }
  }

  // static signInWithEmailPassword(String email, String password) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       Fluttertoast.showToast(msg: 'No user found for that email');
  //     } else if (e.code == 'wrong-password') {
  //       Fluttertoast.showToast(msg: 'Wrong password provided for that user');
  //     } else {
  //       Fluttertoast.showToast(msg: 'Error: $e');
  //     }
  //   }
  // }
}
