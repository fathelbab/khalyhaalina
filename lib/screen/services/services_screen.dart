import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/contact_us_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesScreen extends StatefulWidget {
  static const String route = "/services_screen";

  ServicesScreen({Key? key}) : super(key: key);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  RegExp regex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _phoneNumberText = TextEditingController();
  final _userAddressController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userMessageController = TextEditingController();
  String servicePhoneNumber = "";
  String name = "";
  String serviceAddress = "";
  String serviceName = "";
  @override
  Widget build(BuildContext context) {
    final Map? service = ModalRoute.of(context)!.settings.arguments as Map?;
    serviceName = service != null ? service["serviceName"] : "";
    serviceAddress = service != null ? service["serviceAddress"] : "";
    name = service != null ? service["name"] : "";
    servicePhoneNumber = service != null ? service["servicePhoneNumber"] : "";
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
              if (Navigator.canPop(context)) Navigator.pop(context);
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
                              "الخدمات",
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
                                hintText: "الاسم ",
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 1) {
                                  return "يرجى ادخال الاسم ";
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
                                prefixIcon: Icon(Icons.add_location),
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
                                hintText: "العنوان",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "يرجى ادخال العنوان ";
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
                                  if (value!.isEmpty || value.length < 6) {
                                    return "يرجى ادخال رقم التليفون";
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
                              readOnly: true,
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
                                hintText: name,
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
                              readOnly: serviceName.isNotEmpty ? true : false,
                              controller: _userMessageController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.supervised_user_circle),
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
                                hintText: serviceName,
                              ),
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
                                    " ارسال طلب الخدمة",
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
      Provider.of<CallUsProvider>(context, listen: false)
          .sendUserCompliatOrSuggestion(
        _firstNameController.text.toString(),
        name,
        _userAddressController.text.toString(),
        _phoneNumberText.text.toString(),
        "$servicePhoneNumber/$serviceName/$serviceAddress",
      )
          .then((value) {
        print(value);
        if (value == "done") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  AppLocale.of(context)!.getString("orderSuccessMessage")!)));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocale.of(context)!.getString("addedError")!)));
        }
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("${AppLocale.of(context)!.getString("addedError")}")));
      });
    }
  }
}
