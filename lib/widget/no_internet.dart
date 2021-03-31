import 'package:eshop/language/app_locale.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/connection_loss.png"),
              ),
            ),
          ),
          Text(
            AppLocale.of(context).getString("noInternetConnection"),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).errorColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              AppLocale.of(context).getString("checkInternet"),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
