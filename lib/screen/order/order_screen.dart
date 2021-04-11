import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/order_data.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/order_provider.dart';
import 'package:eshop/screen/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:toast/toast.dart';

class OrderScreen extends StatefulWidget {
  static const route = "/order";
  OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController userNameText = TextEditingController();
  TextEditingController userAddressText = TextEditingController();
  TextEditingController userPhoneNumberText = TextEditingController();
  TextEditingController couponText = TextEditingController();
  final _userAddressFocusNode = FocusNode();
  final _userPhoneNumberFocusNode = FocusNode();
  final _couponFocusNode = FocusNode();

  GlobalKey<FormState> _formkey = GlobalKey();

  @override
  void dispose() {
    super.dispose();

    userNameText.dispose();
    userPhoneNumberText.dispose();
    userAddressText.dispose();
    _userAddressFocusNode.dispose();
    _userPhoneNumberFocusNode.dispose();
    _couponFocusNode.dispose();
    couponText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(AppLocale.of(context).getString('confirmOrder')),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(15.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocale.of(context).getString("totalPrice"),
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(
                          'ج.م ${cart.totalMount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                          controller: userNameText,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_userAddressFocusNode);
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
                          controller: userAddressText,
                          textInputAction: TextInputAction.next,
                          focusNode: _userAddressFocusNode,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_couponFocusNode);
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
                          controller: couponText,
                          textInputAction: TextInputAction.next,
                          focusNode: _couponFocusNode,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_userPhoneNumberFocusNode);
                          },
                          decoration: InputDecoration(
                            hintText: "كود الخصم",
                            border: InputBorder.none,
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
                          controller: userPhoneNumberText,
                          decoration: InputDecoration(
                            hintText:
                                AppLocale.of(context).getString('phoneNumber'),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.phone,
                          focusNode: _userPhoneNumberFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocale.of(context)
                                  .getString('emptyPhoneNumber');
                            }
                            return null;
                          },
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          confirmUserOrder(context, cart);
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
                                AppLocale.of(context).getString("confirmOrder"),
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

  void confirmUserOrder(BuildContext context, Cart cart) async {
    if (!await checkContection()) {
      Toast.show(
        AppLocale.of(context).getString("checkInternetConnection"),
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    }
    bool validator = _formkey.currentState.validate();

    if (userAddressText.text.isNotEmpty &&
        userNameText.text.isNotEmpty &&
        userPhoneNumberText.text.isNotEmpty &&
        validator) {
      List<Orderdeitalsdto> listOfProduct = cart.cartItems
          .map((product) => Orderdeitalsdto(
                productId: product.id,
                price: product.price,
                image: product.image,
                qty: product.qty,
                productName: product.name,
              ))
          .toList();
      if (couponText.text.isEmpty) {
        couponText.text = "";
      }
      bool validator = _formkey.currentState.validate();
      if (userAddressText.text.isNotEmpty &&
          userNameText.text.isNotEmpty &&
          userPhoneNumberText.text.isNotEmpty &&
          validator) {
        final response = await Provider.of<OrderProvider>(context,
                listen: false)
            .createOrder(
                userNameText.text,
                userPhoneNumberText.text,
                "${userAddressText.text}/${couponText.text}",
                cart.totalMount,
                cart.cartItems)
            .then((value) {
          print(value);
          if (value == "done") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    AppLocale.of(context).getString("orderSuccessMessage"))));
            Provider.of<Cart>(context, listen: false).clearCart();
            Provider.of<Cart>(context, listen: false).fetchCartList();
            Navigator.of(context).pushReplacementNamed(CategoryScreen.route);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    AppLocale.of(context).getString("orderErrorMessage"))));
          }
        }).catchError((e) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(AppLocale.of(context).getString("addedError")))));
      } else {
        Toast.show(
          AppLocale.of(context).getString("emptyData"),
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
      }
    }
  }
}
