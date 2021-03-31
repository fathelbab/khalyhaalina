import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/provider/contact_us_provider.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallUsScreen extends StatefulWidget {
  static const String route = "/sign_up_screen";

  CallUsScreen({Key key}) : super(key: key);

  @override
  _CallUsScreenState createState() => _CallUsScreenState();
}

class _CallUsScreenState extends State<CallUsScreen> {
  RegExp regex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _phoneNumberText = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            color: primaryColor,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
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
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(10.0),
                            child: Text(
                              "الشكاوى والاقتراحات",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintStyle: TextStyle(fontSize: 13),
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
                                hintText: "الاسم الاول",
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.length < 1) {
                                  return "يرجى ادخال الاسم الاول";
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
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintStyle: TextStyle(fontSize: 13),
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
                                hintText: "اسم العائله",
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.length < 1) {
                                  return "يرجى ادخال الاسم العائله";
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
                              controller: _emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                hintStyle: TextStyle(fontSize: 13),
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
                                hintText: "البريد الالكترونى",
                              ),
                              validator: (value) {
                                if (value.isEmpty ||
                                    value.indexOf(".") == -1 ||
                                    value.indexOf("@") == -1) {
                                  return "يرجى ادخال البريد الالكترونى ";
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
                                obscureText: true,
                                controller: _phoneNumberText,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  hintStyle: TextStyle(fontSize: 13),
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
                                  hintText: "رقم التليفون",
                                ),
                                validator: (value) {
                                  if (value.isEmpty || value.length < 6) {
                                    return "يرجى ادخال رقم التليفون";
                                  }

                                  return null;
                                }),
                          ),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              obscureText: true,
                              controller: _userMessageController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.comment),
                                hintStyle: TextStyle(fontSize: 13),
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
                                hintText: "الشكاوى والاقتراحات",
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "يرجى ادخال الشكاوى والاقتراحات";
                                }
                                return null;
                              },
                            ),
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
                                    "ارسال",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _phoneNumberText.dispose();
    _userMessageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    } else {
  
        Provider.of<CallUsProvider>(context, listen: false)
            .sendUserCompliatOrSuggestion(
          _firstNameController.text.toString(),
          _lastNameController.text.toString(),
          _emailController.text.toString(),
          _phoneNumberText.text.toString(),
          _userMessageController.text.toString(),
        )
            .then((value) {
          print(value);
          if (value == "done") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text(AppLocale.of(context).getString("addedMessageSuccess"))));
            setState(() {
              _firstNameController.text = "";
              _lastNameController.text = "";
              _emailController.text = "";
              _phoneNumberText.text = "";
              _userMessageController.text = "";
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppLocale.of(context).getString("addedError"))));
          }
        }).catchError((e) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(AppLocale.of(context).getString("addedError")))));
    
    }
  }

  // _showErrorDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //             title: Text('!حدث خطا'),
  //             content: Text("هذا الحساب موجود"),
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 child: Text('حسنا'),
  //               ),
  //             ],
  //           ));
  // }
}
