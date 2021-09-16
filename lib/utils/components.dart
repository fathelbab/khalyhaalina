import 'dart:io';
import 'dart:ui';

import 'package:eshop/language/app_locale.dart';
import 'package:eshop/utils/animations.dart';
import 'package:eshop/utils/style.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



Future<bool> checkConnection() async {
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

_showDialog(String text, BuildContext context) async {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: true,
    transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
      return Animations.grow(_animation, _secondaryAnimation, _child);
    },
    pageBuilder: (_animation, _secondaryAnimation, _child) {
      return AlertDialog(
        title: Icon(
          Icons.priority_high,
          color: Colors.red,
        ),
        content: Text(
          text,
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              getString(context, "cancel"),
              style: TextStyle(
                color: secondaryColor,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<Uri> createDynamicLink(int id) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://khlihaalina.page.link',
    link: Uri.parse('https://khlihaalina.page.link/?id=$id'),
    androidParameters: AndroidParameters(
      packageName: 'com.kira.eshop',
      minimumVersion: 1,
    ),
    dynamicLinkParametersOptions: DynamicLinkParametersOptions(
      shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
    ),
    iosParameters: IosParameters(
      bundleId: 'com.kira.eshop',
      minimumVersion: '1',
    ),
    socialMetaTagParameters: SocialMetaTagParameters(
      title: id.toString(),
      description: "",
    ),
  );

  // Uri url;
  // if (short) {
  //   final ShortDynamicLink shortLink = await parameters.buildShortLink();
  //   url = shortLink.shortUrl;
  // } else {
  //   url = await parameters.buildUrl();
  // }
  var dynamicUrl = await parameters.buildShortLink();
  final Uri shortUrl = dynamicUrl.shortUrl;
  return shortUrl;
}

Future<Uri> createDynamicLinkID(String id) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://khlihaalina.page.link',
    link: Uri.parse('https://www.khlihaalina.com/?id=$id'),
    androidParameters: AndroidParameters(
      packageName: 'com.kira.eshop',
      minimumVersion: 1,
    ),
    iosParameters: IosParameters(
      bundleId: 'com.kira.eshop',
      minimumVersion: '1',
      // appStoreId: 'your_app_store_id',
    ),
  );
  var dynamicUrl = await parameters.buildUrl();

  return dynamicUrl;
}
