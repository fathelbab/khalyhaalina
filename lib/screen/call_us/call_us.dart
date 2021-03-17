import 'package:eshop/language/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.of(context).getString('callUs')),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '+2 01145227769',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textDirection: TextDirection.ltr,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  
                  Icons.phone,
                  color: Theme.of(context).primaryColor,
                  size: 25,
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: _launchURL,
              child: Text(
                AppLocale.of(context).getString('callUs'),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL() async => await canLaunch("tel:+201145227769")
      ? await launch("tel:+201145227769")
      : throw 'Could not launch +201145227769';
}
