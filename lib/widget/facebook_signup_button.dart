import 'package:eshop/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FacebookSignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton.icon(
        label: Text(
          " تسجيل الدخول",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        style: OutlinedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.all(5),
        ),
        icon: FaIcon(
          FontAwesomeIcons.facebook,
        ),
        onPressed: () {
          final provider = Provider.of<Auth>(context, listen: false);
          // provider.googleLogin();
        },
      ),
    );
  }
}
