import 'package:eshop/provider/doctor_provider.dart';
import 'package:eshop/screen/home/home_screen.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorBookedScreen extends StatefulWidget {
  static const String route = "/doctor_booked_screen";

  final String? bookedDate;
  final String? doctorId;
  DoctorBookedScreen({Key? key, this.doctorId, this.bookedDate})
      : super(key: key);

  @override
  _DoctorBookedScreenState createState() => _DoctorBookedScreenState();
}

class _DoctorBookedScreenState extends State<DoctorBookedScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _phoneNumberText = TextEditingController();
  final _nameText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          getString(context, "confirmDoctorBooked"),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            getString(context, "bookedDate"),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${widget.bookedDate!.split("\\")[0]}  ${widget.bookedDate!.split("\\")[1]}",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: _nameText,
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
                            hintText: getString(context, "name"),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 1) {
                              return getString(context, "emptyName");
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
                              hintText: "رقم التليفون",
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return "يرجى ادخال رقم التليفون";
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
                                getString(context, "sendDoctorBooked"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
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
    _nameText.dispose();
    _phoneNumberText.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    } else {
      checkConnection().then((value) {
        if (value) {
          Provider.of<DoctorProvider>(context, listen: false)
              .sendDoctorBookedDate(
            _nameText.text.toString(),
            _phoneNumberText.text.toString(),
            widget.doctorId!,
            widget.bookedDate!,
          )
              .then((value) {
            print(value);
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
