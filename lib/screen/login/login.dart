import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:eshop/screen/signup/signup.dart';
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
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.0,
        //   leading: IconButton(
        //     color: primaryColor,
        //     icon: Icon(Icons.arrow_back_ios),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
        
            children: [
              Expanded(
                  child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Text(
                     AppLocale.of(context).getString('loginText'),
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
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: AppLocale.of(context).getString('email'),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value.isEmpty ||
                              value.indexOf(".") == -1 ||
                              value.indexOf("@") == -1) {
                            return AppLocale.of(context).getString('emptyEmail');
                          }return null;
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
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: AppLocale.of(context).getString('password'),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length < 6) {
                            return AppLocale.of(context).getString("emptyPassword");
                          }return null;
                        },
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     // Navigator.push(
                    //     //     context,
                    //     //     MaterialPageRoute(
                    //     //         builder: (context) => ForgetPassword()));
                    //   },
                    //   child: Container(
                    //     child: Text("Forget Password"),
                    //     margin:
                    //         EdgeInsets.only(left: 15.0, top: 5.0, bottom: 10.0),
                    //   ),
                    // ),
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
                              "الدخول",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                      ),
                    )
                  ],
                ),
              )),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "انشاء حساب جديد",
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
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
              title: Text('An error Occurred!'),
              content: Text("Incorrect Email Or Password"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('okey'),
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
