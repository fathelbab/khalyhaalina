import 'dart:io';
import 'dart:ui';

import 'package:eshop/language/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// const String apiPath = "http://eshop5827-001-site3.etempurl.com/api";
const String apiPath = "https://api.khlihaalina.com/api";
// const String imagePath = "http://eshop5827-001-site3.etempurl.com";
const String imagePath = "https://api.khlihaalina.com/";
const Color primaryColor = Color(0xFF5c8bb0);
const Color secondaryColor = Color(0XFFE5A352);
Future<bool> checkContection() async {
  try {
    final result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print("connect");
      return true;
    } else {
      print("disconnect");
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

Widget generateBluredImage() {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
            'https://f6j7u7c7.stackpathcdn.com/wp-content/uploads/2018/01/Ecommerce-Website-1.jpeg'),
        fit: BoxFit.fill,
      ),
    ),

    //I blured the parent container to blur background image, you can get rid of this part
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Container(
        //you can change opacity with color here(I used black) for background.
        decoration: new BoxDecoration(color: primaryColor.withOpacity(0.9)),
      ),
    ),
  );
}

String getString(BuildContext context, String key) {
  return AppLocale.of(context)!.getString(key).toString();
}
showToast({
  required String text,
  Toast length = Toast.LENGTH_LONG,
  ToastGravity gravity = ToastGravity.BOTTOM,
  Color bgColor = Colors.black,
  Color textColor = Colors.white,
  double fontSize = 16.0,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: length,
    gravity: gravity,
    timeInSecForIosWeb: 3,
    backgroundColor: bgColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}