import 'dart:async';
import 'package:eshop/provider/configurations_provider.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardsScreen extends StatefulWidget {
  static const String route = "/rewards";
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    // timer = Timer(
    //   const Duration(seconds: 7),
    //   () => Navigator.of(context).pushReplacementNamed(
    //     HomeScreen.route,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigurationProvider>(
      builder: (context, configuration, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            getString(context, "rewards"),
          ),
          centerTitle: true,
          leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Image.network(
                Constants.imagePath +
                    configuration.configuration!.gif.toString(),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
