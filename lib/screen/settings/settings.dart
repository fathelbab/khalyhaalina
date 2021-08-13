import 'package:eshop/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eshop/utils/style.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const String route = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDark = false;
  @override
  void initState() {
    super.initState();
    // isDark = Provider.of<ThemeProvider>(context).isDark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'Hello ',
              style: Theme.of(context).textTheme.headline6,
            ),
            Divider(),
            Switch(
                value: isDark,
                activeColor: primaryColor,
                
                onChanged: (value) {
                  isDark = !isDark;
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme(value);
                }),
          ],
        ),
      ),
    );
  }
}
