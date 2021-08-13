import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:eshop/widget/default_button.dart';
import 'package:eshop/widget/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static const String route = "/sign_up_screen";

  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegExp regex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        generateBluredImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(top: kToolbarHeight, bottom: 15),
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
                          controller: _firstNameController,
                          prefixIcon: Icons.person,
                          hint: AppLocale.of(context)!.getString("firstName")!,
                          validatorFunction: (value) {
                            if (value!.isEmpty || value.length < 1) {
                              return AppLocale.of(context)!
                                  .getString("firstNameError")!;
                            }
                            return null;
                          },
                        ),
                        DefaultFormField(
                          controller: _lastNameController,
                          prefixIcon: Icons.person,
                          hint: AppLocale.of(context)!.getString("familyName")!,
                          validatorFunction: (value) {
                            if (value!.isEmpty || value.length < 1) {
                              return AppLocale.of(context)!
                                  .getString("familyNameError")!;
                            }
                            return null;
                          },
                        ),
                        DefaultFormField(
                          controller: _emailController,
                          hint: AppLocale.of(context)!.getString("email")!,
                          prefixIcon: Icons.mail_outline,
                          validatorFunction: (value) {
                            if (value!.isEmpty ||
                                value.indexOf(".") == -1 ||
                                value.indexOf("@") == -1) {
                              return AppLocale.of(context)!
                                  .getString("emptyEmail")!;
                            }
                            return null;
                          },
                        ),
                        DefaultFormField(
                            isPassword: isPassword,
                            suffixIcon: isPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                            prefixIcon: Icons.lock_outline,
                            controller: _passwordController,
                            hint: AppLocale.of(context)!.getString("password")!,
                            validatorFunction: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return AppLocale.of(context)!
                                    .getString("emptyPassword")!;
                              } else {
                                if (!regex.hasMatch(value))
                                  return AppLocale.of(context)!
                                      .getString("correctPassword")!;
                                else
                                  return null;
                              }
                            }),
                        DefaultFormField(
                          prefixIcon: Icons.lock,
                          controller: _passwordConfirmController,
                          hint: AppLocale.of(context)!
                              .getString("confirmPassword")
                              .toString(),
                          validatorFunction: (value) {
                            if (_passwordConfirmController.text !=
                                _passwordController.text) {
                              return AppLocale.of(context)!
                                  .getString("emptyPassword")
                                  .toString();
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DefaultButton(
                    text: AppLocale.of(context)!.getString("signUp")!,
                    function: () {
                      _submit();
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocale.of(context)!
                              .getString("aleardyHaveAccount")!,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
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
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            AppLocale.of(context)!.getString("login")!,
                            style: TextStyle(
                              fontSize: 19.0,
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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    } else {
      try {
        await Provider.of<Auth>(context, listen: false).userRegister(
            _emailController.text.toString(),
            _passwordController.text.toString(),
            _firstNameController.text.toString(),
            _lastNameController.text.toString());

        Navigator.pushReplacementNamed(context, Login.route);
      } catch (e) {
        print(e.toString());
        _showErrorDialog();
      }
    }
  }

  _showErrorDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('!حدث خطا'),
              content: Text("هذا الحساب موجود"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('حسنا'),
                ),
              ],
            ));
  }
}
