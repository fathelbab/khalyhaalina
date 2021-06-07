import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/screen/city/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GoogleSignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool? isGoogleLogin = Provider.of<Auth>(context).isSigningIn;
    return InkWell(
      onTap: () {
        final provider = Provider.of<Auth>(context, listen: false);
        if (isGoogleLogin!) {
          provider.logout();
        } else {
          provider.googleLogin().then((value) {
            print(value);
            if (value == "done") {
              Navigator.of(context).pushReplacementNamed(CityScreen.route);
            } else {
              _showErrorDialog(context);
            }
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: FaIcon(
          FontAwesomeIcons.google,
          color: Colors.red,
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
