import 'dart:convert';
import 'dart:io';
import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/pharmacy_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';

class PharmacyScreen extends StatefulWidget {
  PharmacyScreen({Key key}) : super(key: key);

  @override
  _PharmacyScreenState createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  var checkActive = false;
  var isLoading = false;
  File _image;
  final picker = ImagePicker();
  TextEditingController pharmacyNameText = TextEditingController();
  TextEditingController pharmacyAddressText = TextEditingController();
  TextEditingController pharmacyPhoneNumberText = TextEditingController();
  final _pharmacyAddressFocusNode = FocusNode();
  final _pharmacyPhoneNumberFocusNode = FocusNode();

  GlobalKey<FormState> _formkey = GlobalKey();
  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image.path.toString());
      } else {
        print(AppLocale.of(context).getString('emptyImage'));
      }
    });
  }

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // uploadImageFile(_image);
        print(_image.path.toString());
      } else {
        print(AppLocale.of(context).getString('emptyImage'));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    pharmacyNameText.dispose();
    pharmacyPhoneNumberText.dispose();
    pharmacyAddressText.dispose();
    _pharmacyAddressFocusNode.dispose();
    _pharmacyPhoneNumberFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(AppLocale.of(context).getString('pharmacy')),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formkey,
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: TextFormField(
                          controller: pharmacyNameText,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_pharmacyAddressFocusNode);
                          },
                          decoration: InputDecoration(
                            hintText: AppLocale.of(context).getString('name'),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value.isEmpty || value.length < 1) {
                              return AppLocale.of(context)
                                  .getString("emptyName");
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: TextFormField(
                          controller: pharmacyAddressText,
                          focusNode: _pharmacyAddressFocusNode,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_pharmacyPhoneNumberFocusNode);
                          },
                          decoration: InputDecoration(
                            hintText:
                                AppLocale.of(context).getString('address'),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocale.of(context)
                                  .getString('emptyAddress');
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: TextFormField(
                          controller: pharmacyPhoneNumberText,
                          decoration: InputDecoration(
                            hintText:
                                AppLocale.of(context).getString('phoneNumber'),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.phone,
                          focusNode: _pharmacyPhoneNumberFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocale.of(context)
                                  .getString('emptyPhoneNumber');
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            icon: Icon(
                              Icons.image,
                              size: 50,
                              color: primaryColor,
                            ),
                            onPressed: () {
                              showSheetGallery(context);
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        child: (_image == null)
                            ? Text(
                                AppLocale.of(context).getString('emptyImage'))
                            : Image.file(
                                _image,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                      ),
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : MaterialButton(
                              onPressed: () {
                                savePharmacyData(
                                  context,
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      AppLocale.of(context).getString("save"),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void savePharmacyData(BuildContext context) async {
    if (!await checkContection()) {
      Toast.show(
        AppLocale.of(context).getString("checkInternetConnection"),
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    }
    bool validator = _formkey.currentState.validate();

    if (pharmacyAddressText.text.isNotEmpty &&
        pharmacyNameText.text.isNotEmpty &&
        pharmacyPhoneNumberText.text.isNotEmpty &&
        validator) {
      isLoading = true;
      String imageBase64String = base64Encode(_image.readAsBytesSync());
      Provider.of<PharmacyProvider>(context, listen: false)
          .addPharmacyItem(
        pharmacyNameText.text,
        pharmacyAddressText.text,
        pharmacyPhoneNumberText.text,
        imageBase64String,
      )
          .then((value) {
        print(value);
        if (value == "done") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocale.of(context).getString("addedSuccess"))));
          setState(() {
            isLoading = false;
            pharmacyNameText.text = "";
            pharmacyAddressText.text = "";
            pharmacyPhoneNumberText.text = "";
            _image = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocale.of(context).getString("addedError"))));
        }
      }).catchError((e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocale.of(context).getString("addedError")))));
      // Map arr = {
      //   "cat_name": categoryNameText.text,
      //   "cat_name_en": categoryNameEnText.text,
      // };
      // bool result = await uploadImageFileWithData(_image, arr,
      //     "category/insert_category.php", context, () => Category(), "insert");
      //  await createData(
      //     arr, "category/insert_category.php", context, () => Category());

    } else {
      Toast.show(
        AppLocale.of(context).getString("emptyData"),
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    }
  }

  void showSheetGallery(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text(AppLocale.of(context).getString("imageGallery")),
                  onTap: () {
                    getImageGallery();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text(AppLocale.of(context).getString("camera")),
                  onTap: () {
                    getImageCamera();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}
