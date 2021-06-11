import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String? s) validatorFunction;
  final bool isPassword;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? suffixPressed;
  DefaultFormField({
    required this.controller,
    required this.hint,
    required this.validatorFunction,
    this.isPassword = false,
    required this.prefixIcon,
    this.suffixIcon,
    this.suffixPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.only(right: 10, left: 10),
      child: TextFormField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(fontSize: 13),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
          border: new OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(suffixIcon),
                )
              : null,
          hintText: hint,
        ),
        validator: validatorFunction,
      ),
    );
  }
}
