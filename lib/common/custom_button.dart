import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    this.onPressed,
    required this.buttonText,
    required this.filledColor,
    required this.buttonTextColor,
  });
  final VoidCallback? onPressed;
  final String buttonText;
  final Color filledColor;
  final Color buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(backgroundColor: filledColor),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: buttonTextColor),
        ),
      ),
    );
  }
}
