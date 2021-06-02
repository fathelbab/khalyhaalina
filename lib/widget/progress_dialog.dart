import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String message;

  const ProgressDialog({this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(width: 6.0),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(width: 6.0),
            Text(message),
          ],
        ),
      ),
    );
  }
}
