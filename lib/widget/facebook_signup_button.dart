import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/screen/category_screen.dart';
import 'package:eshop/screen/city/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FacebookSignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<Auth>(context, listen: false).facebookLogin().then((value) {
          if (value == "done") {
            print("abdo value >>> $value");
            Navigator.of(context).pushReplacementNamed(CityScreen.route);
          } else {
            print("abdo value >>> $value");
            _showErrorDialog(context);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: FaIcon(
          FontAwesomeIcons.facebook,
          color: Colors.blue,
          size: 30,
        ),
      ),
    );
  }

  _showErrorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('!تنبيه'),
              content: Text("حدث خطا ما يرجى المحاولة مرة اخرى ؟"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('حسنا'),
                ),
              ],
            ));
  }
}
