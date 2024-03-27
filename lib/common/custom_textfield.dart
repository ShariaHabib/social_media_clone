import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media_clone/common/constants.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      required this.editingController,
      required this.hintText,
      this.obscureText = false,
      this.validator,
      this.leadingIcon,
      this.isSecure = false,
      this.labelText});

  final TextEditingController editingController;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  Icon? leadingIcon;
  IconButton? trailingIcon;
  bool isSecure;
  final String? labelText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  @override
  void initState() {
    _obscureText = widget.isSecure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.editingController,
      obscureText: _obscureText,
      validator: widget.validator,
      style: TextStyle(
        color: Constants.secondaryColor,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: Theme.of(context).textTheme.bodySmall!.fontSize),
        prefixIcon: widget.leadingIcon,
        suffixIcon: widget.isSecure
            ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Constants.secondaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : SizedBox(),
      ),
    );
  }
}
