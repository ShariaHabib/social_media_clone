import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clone/common/constants.dart';
import 'package:social_media_clone/firebase_options.dart';
import 'package:social_media_clone/screens/dashboard.dart';
import 'package:social_media_clone/screens/forget_password.dart';
import 'package:social_media_clone/screens/sign_in.dart';
import 'package:social_media_clone/screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: Constants.customTextTheme.bodySmall!.fontFamily!,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: SignIn(),
      routes: {
        '/signup': (context) => SignUp(),
        '/signin': (context) => SignIn(),
        '/dashboard': (context) => Dashboard(),
        '/forgetpassword': (context) => ForgetPassword(),
      },
    );
  }
}
