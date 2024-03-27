import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static const String signUpText = "Let's create ";
  static const String signUpText2 = "Your Account";
  static const String hintEmail = "Enter your email";
  static const String hintPassword = "Enter your password";
  static const String hintConfirmPassword = "Confirm your password";
  static const String registerButton = "Agree and Continue";
  static const String loginButton = "Log in";
  static const String forgotPassword = "Forgot Password?";
  static const String backgroundImage =
      "https://images.unsplash.com/photo-1562814830-8286a3397045";

  static const Color primaryColor = Color(0xFF24459c);
  static const Color secondaryColor = Color(0xFF4D5983);
  static const Color textColor = Color(0xFFE5E5E5);
  static const double fontSmall = 12;
  static const double fontMedium = 16;
  static const double fontLarge = 25;
  static TextTheme customTextTheme = TextTheme(
    titleLarge: GoogleFonts.interTextTheme().titleLarge,
    bodySmall: GoogleFonts.roboto(),
  );
}
