import 'dart:io';

import 'package:flutter/material.dart';

// const String apiPath = "http://eshop5827-001-site3.etempurl.com/api";
const String apiPath = "http://eshop5827-001-site4.etempurl.com/api";
// const String imagePath = "http://eshop5827-001-site3.etempurl.com";
const String imagePath = "http://eshop5827-001-site4.etempurl.com/";
 const Color primaryColor=Color(0xFF5c8bb0);
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