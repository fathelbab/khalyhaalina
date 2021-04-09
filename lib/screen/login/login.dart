import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:eshop/screen/signup/signup.dart';
import 'package:eshop/widget/facebook_signup_button.dart';
import 'package:eshop/widget/google_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String route = "/login_screen";

  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
                          margin: EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          child: Text(
                            AppLocale.of(context).getString("login"),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
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
                              prefixIcon: Icon(Icons.email),
                              hintText:
                                  AppLocale.of(context).getString('email'),
                            ),
                            validator: (value) {
                              if (value.isEmpty ||
                                  value.indexOf(".") == -1 ||
                                  value.indexOf("@") == -1) {
                                return AppLocale.of(context)
                                    .getString('emptyEmail');
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 13),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              prefixIcon: Icon(Icons.lock),
                              hintText:
                                  AppLocale.of(context).getString('password'),
                            ),
                            validator: (value) {
                              if (value.isEmpty || value.length < 6) {
                                return AppLocale.of(context)
                                    .getString("emptyPassword");
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
                                  AppLocale.of(context).getString("login"),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              height: 1,
                              width: MediaQuery.of(context).size.width / 3,
                              color: Colors.grey,
                            ),
                            Text("او"),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              height: 1,
                              width: MediaQuery.of(context).size.width / 3,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FacebookSignupButton(),
                            GoogleSignupButton(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "ليس لديك حساب؟",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: primaryColor,
                                ),
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
                                  "انشاء حساب",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
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
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    } else {
      try {
        await Provider.of<Auth>(context, listen: false).userSignIn(
          _emailController.text.toString(),
          _passwordController.text.toString(),
        );

        Navigator.pushReplacementNamed(context, HomeScreen.route);
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
