import 'dart:ui';
import 'package:eshop/screen/address/governorate_screen.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/screen/signup/signup.dart';
import 'package:eshop/widget/default_button.dart';
import 'package:eshop/widget/default_form_field.dart';
import 'package:eshop/widget/facebook_signup_button.dart';
import 'package:eshop/widget/google_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String route = "/login_screen";

  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        generateBluredImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 25),
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      image: DecorationImage(
                          image: AssetImage("assets/images/app_logo.png"),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        DefaultFormField(
                          controller: _emailController,
                          hint: AppLocale.of(context)!
                              .getString('email')
                              .toString(),
                          validatorFunction: (value) {
                            if (value!.isEmpty ||
                                value.indexOf(".") == -1 ||
                                value.indexOf("@") == -1) {
                              return AppLocale.of(context)!
                                  .getString('emptyEmail');
                            }
                            return null;
                          },
                          prefixIcon: Icons.email,
                        ),
                        DefaultFormField(
                          controller: _passwordController,
                          hint: AppLocale.of(context)!
                              .getString('password')
                              .toString(),
                          validatorFunction: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return AppLocale.of(context)!
                                  .getString("emptyPassword");
                            }
                            return null;
                          },
                          isPassword: isPassword,
                          suffixIcon: isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          prefixIcon: Icons.lock,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DefaultButton(
                    text: AppLocale.of(context)!.getString("login")!,
                    function: () {
                      _submit();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   alignment: Alignment.topRight,
                  //   margin: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       AppLocale.of(context)!
                  //           .getString("forgetPassword")
                  //           .toString(),
                  //       style: TextStyle(
                  //           fontSize: 18.0,
                  //           color: secondaryColor,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 1,
                        width: MediaQuery.of(context).size.width / 3,
                        color: Colors.white,
                      ),
                      Text(
                        AppLocale.of(context)!.getString("or").toString(),
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 1,
                        width: MediaQuery.of(context).size.width / 3,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FacebookSignupButton(),
                      GoogleSignupButton(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocale.of(context)!
                              .getString("accountNotExists")
                              .toString(),
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            AppLocale.of(context)!
                                .getString("createAccount")
                                .toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    alignment: Alignment.topRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocale.of(context)!
                              .getString("termsAgreement")
                              .toString(),
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppLocale.of(context)!
                                .getString("termsAndConditions")
                                .toString(),
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    } else {
      try {
        await Provider.of<Auth>(context, listen: false).userSignIn(
          _emailController.text.toString(),
          _passwordController.text.toString(),
        );

        Navigator.pushReplacementNamed(context, GovernorateScreen.route);
      } catch (e) {
        _showErrorDialog();
      }
    }
  }

  _showErrorDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('!تنبيه'),
              content: Text("البريد الالكترونى او كلمة مرور غير صحيحة؟"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('حسنا'),
                ),
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
