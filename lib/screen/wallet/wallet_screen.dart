import 'package:eshop/provider/configurations_provider.dart';
import 'package:eshop/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  static const String route = "/wallet";
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final configuration =
        Provider.of<ConfigurationProvider>(context).configuration;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getString(context, "appWallet"),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
            "${configuration!.minLimt.toString()} ${configuration.discount.toString()}"),
      ),
    );
  }
}
