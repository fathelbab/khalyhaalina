import 'package:eshop/constant/constant.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static const String route = "/sign_up_screen";

  SignUp({Key key}) : super(key: key);

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
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(
                            "انشاء حساب جديد",
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
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              hintText: "الاسم الاول",
                              border: InputBorder.none,
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
                          padding: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              hintText: "اسم العائله",
                              border: InputBorder.none,
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
                          padding: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "البريد الالكترونى",
                              border: InputBorder.none,
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
                          padding: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: "كلمة المرور",
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.length < 6) {
                                  return "يرجى ادخال كلمة المرور";
                                } else {
                                  if (!regex.hasMatch(value))
                                    return 'يرجى ادخال كلمة السر بطريقة صحيحه';
                                  else
                                    return null;
                                }
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.all(5.0),
                          padding: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordConfirmController,
                            decoration: InputDecoration(
                              hintText: "تاكيد كلمة المرور",
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (_passwordConfirmController.text !=
                                  _passwordController.text) {
                                return "يرجى تاكيد كلمة المرور";
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
                                  "انشاء حساب",
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "لدى حساب بالفعل",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "الدخول",
                          style: TextStyle(
                            fontSize: 20.0,
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
    if (!_formKey.currentState.validate()) {
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
