import 'package:eshop/language/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 20,
        title: Text(AppLocale.of(context).getString("info")),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
               ListTile(
              title: Text(
                AppLocale.of(context).getString('location'),
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
              onTap: () => _launchURL("https://www.google.com/maps?q=30.7163794,31.26246&z=17&hl=en"),
            ),
            ListTile(
              title: Text(
                AppLocale.of(context).getString('callUs'),
              ),
              leading: Icon(
                Icons.phone,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              subtitle: Text(
                '+2 01229337175',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textDirection: TextDirection.ltr,
              ),
              onTap: () => _launchURL("tel:+201229337175"),
            ),
            ListTile(
              title: Text(
                AppLocale.of(context).getString('callUs'),
              ),
              leading: Icon(
                Icons.phone,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              subtitle: Text(
                '0504954526',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textDirection: TextDirection.ltr,
              ),
              onTap: () => _launchURL("tel:0504954526"),
            ),
         
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GFButton(
                  onPressed: () {
                    _launchURL("https://www.facebook.com/Khliha.Alina/");
                  },
                  text: "Facebook",
                  icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
                ),
                GFButton(
                  onPressed: () {
                    _launchURL(
                        "https://youtube.com/channel/UC5PLSqKI3glakYfXtkk4uOA");
                  },
                  text: "Youtube",
                  color: Colors.red,
                  icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.white),
                ),
                GFButton(
                  onPressed: () {
                    _launchURL(
                        "http://eshop5827-001-site1.etempurl.com/shoping/home");
                  },
                  text: "Eshop",
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  color: Colors.black,
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
