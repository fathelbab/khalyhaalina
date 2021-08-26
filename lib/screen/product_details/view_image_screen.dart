import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';

class ViewImageScreen extends StatefulWidget {
  static const String route = "/view_image";
  final String? image;
  ViewImageScreen({Key? key, this.image}) : super(key: key);

  @override
  _ViewImageScreenState createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: secondaryColor,
                      size: 30,
                    )),
              ],
            ),
            Expanded(
              flex: 1,
              child: InteractiveViewer(
                child: Image.network(
                  Constants.imagePath + widget.image!,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
