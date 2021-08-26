import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/configurations_provider.dart';
import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class InfoScreen extends StatelessWidget {
  static const String route = "/info";
  @override
  Widget build(BuildContext context) {
    final configuration =
        Provider.of<ConfigurationProvider>(context).configuration;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 20,
        title: Text(AppLocale.of(context)!.getString("info")!),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text(
                AppLocale.of(context)!.getString('location')!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              leading: Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
              trailing: FaIcon(FontAwesomeIcons.map),
              onTap: () => _launchURL(
                  "https://www.google.com/maps?q=30.7163794,31.26246&z=17&hl=en"),
            ),

            ListTile(
              title: Text(
                AppLocale.of(context)!.getString('callUs')!,
              ),
              leading: Icon(
                Icons.phone,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              subtitle: Text(
                "${configuration!.phoneNumber1}",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textDirection: TextDirection.ltr,
              ),
              onTap: () => _launchURL("tel:${configuration.phoneNumber1}"),
            ),
            ListTile(
              title: Text(
                AppLocale.of(context)!.getString('callUs')!,
              ),
              leading: Icon(
                Icons.phone,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              subtitle: Text(
                "${configuration.phoneNumber2}",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textDirection: TextDirection.ltr,
              ),
              onTap: () => _launchURL("tel:${configuration.phoneNumber2}"),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 5,
              children: [
                GFButton(
                  onPressed: () {
                    _launchURL("${configuration.linkFaceBook}");
                  },
                  text: "Facebook",
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
                ),
                GFButton(
                  onPressed: () {
                    _launchURL("${configuration.linkYouTube}");
                  },
                  text: "Youtube",
                  color: Colors.red,
                  icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.white),
                ),
                GFButton(
                  onPressed: () {
                    _launchURL("${configuration.linkWebSite}");
                  },
                  text: "Tiktok",
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  color: Colors.black,
                  elevation: 5,
                  icon: FaIcon(FontAwesomeIcons.tiktok, color: Colors.white),
                ),
                GFButton(
                  onPressed: () {
                    _launchURL("${configuration.linkWebSite}");
                  },
                  text: "Eshop",
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  color: primaryColor,
                  elevation: 5,
                  icon: FaIcon(FontAwesomeIcons.globe, color: Colors.white),
                ),
                GFButton(
                  onPressed: () {
                    _launchURL("${configuration.linkInstagram}");
                  },
                  text: "Instagram",
                  textStyle: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold),
                  color: Colors.white,
                  elevation: 5,
                  icon:
                      FaIcon(FontAwesomeIcons.instagram, color: Colors.purple),
                ),
                GFButton(
                  onPressed: () {
                    _launchURL("${configuration.linkWebSite}");
                  },
                  text: "Eshop",
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  color: primaryColor,
                  elevation: 5,
                  icon: FaIcon(FontAwesomeIcons.globe, color: Colors.white),
                ),
              ],
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     onPrimary: Colors.white,
            //     primary: Theme.of(context).primaryColor,
            //   ),
            //   child: Text(
            //     AppLocale.of(context).getString('callUs'),
            //     style: TextStyle(
            //       fontSize: 18,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
