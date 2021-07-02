import 'dart:async';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  static const String route = "/intro";
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(seconds: 7),
      () => Navigator.of(context).pushReplacementNamed(
        HomeScreen.route,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.network(
      "https://i.gifer.com/7NbX.gif",
    ));
  }
}
