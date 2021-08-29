import 'package:eshop/provider/configurations_provider.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/style.dart';
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
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            getString(context, "walletTitle"),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset("assets/images/wallet.png"),
          Text(
            getString(context, "walletSubtitle"),
            style: TextStyle(color: secondaryColor, fontSize: 25),
          ),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  // "${getString(context, "walletDescription")} ${configuration!.minLimt.toString()} ${getString(context, "walletSubDescrition")} ${configuration.discount.toString()}"),
                  TextSpan(
                    text: "${getString(context, "walletDescription")} ",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 18,
                      fontFamily: "Anton",
                    ),
                  ),
                  TextSpan(
                    text: "${configuration!.discount.toString()} ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "${getString(context, "currency")} ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Anton",
                    ),
                  ),
                  TextSpan(
                    text: "${getString(context, "walletSubDescrition")}",
                    style: TextStyle(
                      fontSize: 18,
                      color: secondaryColor,
                      fontFamily: "Anton",
                    ),
                  ),
                  TextSpan(
                    text: "${configuration.minLimt.toString()} ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "${getString(context, "currency")}",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Anton",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
