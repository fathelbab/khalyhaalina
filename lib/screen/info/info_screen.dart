import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/configurations_provider.dart';
import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoScreen extends StatelessWidget {
  static const String route = "/info";
  @override
  Widget build(BuildContext context) {
    final configuration =
        Provider.of<ConfigurationProvider>(context).configuration;
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   elevation: 20,
      //   title: Text(AppLocale.of(context)!.getString("info")!),
      // ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _launchURL("${configuration!.linkWebSite}");
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/app_logo.png"),
                    scale: 1,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
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
                  fontSize: 20,
                ),
                textDirection: TextDirection.ltr,
              ),
              onTap: () => _launchURL("tel:${configuration.phoneNumber2}"),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 10,
              children: [
                InkWell(
                  onTap: () {
                    _launchURL("${configuration.linkFaceBook}");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL("${configuration.linkYouTube}");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.youtube,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     padding: const EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       shape: BoxShape.circle,
                // boxShadow: [
                //       BoxShadow(
                //         color: Colors.red,
                //         blurRadius: 4,
                //         offset: Offset(4, 8), // Shadow position
                //       ),
                //     ],
                //     ),
                //     child: FaIcon(
                //       FontAwesomeIcons.,
                //       color: Colors.,
                //       size: 30,
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    _launchURL("${configuration.linkTikTok}");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.tiktok,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL("${configuration.linkInstagram}");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Colors.purple,
                      size: 30,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL("${configuration.linkWebSite}");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: secondaryColor,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.globe,
                      color: secondaryColor,
                      size: 30,
                    ),
                  ),
                ),

                // GFButton(
                //   onPressed: () {
                //     _launchURL("${configuration.linkInstagram}");
                //   },
                //   text: "Instagram",
                //   textStyle: TextStyle(
                //       color: Colors.purple, fontWeight: FontWeight.bold),
                //   color: Colors.white,
                //   elevation: 5,
                //   icon:
                //       FaIcon(FontAwesomeIcons.instagram, color: Colors.purple),
                // ),
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
