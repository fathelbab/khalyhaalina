import 'package:eshop/provider/contact_us_provider.dart';
import 'package:eshop/provider/doctor_provider.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnlineSupportScreen extends StatefulWidget {
  static const String route = "/online_support_screen";

  @override
  _OnlineSupportScreenState createState() => _OnlineSupportScreenState();
}

class _OnlineSupportScreenState extends State<OnlineSupportScreen> {
  RegExp regex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _phoneNumberText = TextEditingController();
  final _userAddressController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userMessageController = TextEditingController();
  final _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          getString(context, "onlineSupport"),
          style: TextStyle(fontSize: 20),
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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: primaryColor,
                            ),
                            hintStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            hintText: getString(context, "firstName"),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 1) {
                              return getString(context, "firstNameError");
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: primaryColor,
                            ),
                            hintStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            hintText: getString(context, "familyName"),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 1) {
                              return getString(context, "familyNameError");
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _userAddressController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.add_location,
                              color: primaryColor,
                            ),
                            hintStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            hintText: getString(context, "address"),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return getString(context, "emptyAddress");
                            }
                            return null;
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                            controller: _phoneNumberText,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone,
                                color: primaryColor,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              hintText: getString(context, "phoneNumber"),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return getString(context, "emptyPhoneNumber");
                              }

                              return null;
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                            controller: _commentController,
                            minLines: 3,
                            maxLines: 6,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.comment,
                                color: primaryColor,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 2.1,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              hintText: getString(context, "comment"),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return getString(context, "emptyComment");
                              }
                              return null;
                            }),
                      ),

                      MaterialButton(
                        onPressed: () {
                          _submit();
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
                                getString(context, "send"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.all(5.0),
                      //   child: Text("Agree to our terms and conditions"),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userAddressController.dispose();
    _phoneNumberText.dispose();
    _userMessageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    } else {
      checkConnection().then((value) {
        if (value) {
          Provider.of<ContactUsProvider>(context, listen: false)
              .sendOnlineSupport(
            _firstNameController.text.toString(),
            _lastNameController.text.toString(),
            _userAddressController.text.toString(),
            _phoneNumberText.text.toString(),
            _commentController.text.toString(),
          )
              .then((value) {
            if (value == "done") {
              showToast(
                text: getString(context, "confirmedDoctorBookedMessage"),
                bgColor: Colors.green,
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.route, (route) => false);
            } else {
              showToast(
                text: getString(context, "orderErrorMessage"),
                bgColor: Colors.red,
              );
            }
          }).catchError((e) {
            showToast(
              text: getString(context, "orderErrorMessage"),
              bgColor: Colors.red,
            );
          });
        } else {
          showToast(
            text: getString(context, "failedConnectToInternet"),
            bgColor: Colors.red,
          );
        }
      }).catchError((e) {
        showToast(
          text: getString(context, "failedConnectToInternet"),
          bgColor: Colors.red,
        );
      });
    }
  }
}
