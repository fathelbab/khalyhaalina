import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final Color backgroundColor, textColor;
  final FontWeight fontWeight;
  final double fontSize;
  DefaultButton({
    required this.text,
    required this.function,
    this.backgroundColor = primaryColor,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: function,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white)),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: fontWeight,
                fontSize: fontSize,
              ),
            )),
      ),
    );
  }
}
