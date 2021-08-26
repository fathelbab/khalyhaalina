import 'package:eshop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  static const String route = "/terms_and_conditions";
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Html(
              data: Constants.condiitons,
            ),
          ),
        ),
      ),
    );
  }
}
