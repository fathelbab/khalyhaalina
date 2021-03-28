import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/cart_data.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/screen/order/order_screen.dart';
import 'package:eshop/widget/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// use show to select which class will use in this file here will use cart class
// and don't use CartItem or hide it from CartScreen

class CartScreen extends StatelessWidget {
  static const route = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocale.of(context).getString('cart'),
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocale.of(context).getString("total"),
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
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return CartItem(
                  productId: cart.cartItems[index].productid.toString(),
                  price: cart.cartItems[index].price,
                  quantity: cart.cartItems[index].qty,
                  title: cart.cartItems[index].name,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // double getTotalPrice(List<CartData> cartItems) {
  //   var total = 0.0;
  //   cartItems.forEach((item)  {
  //     total += item.price * item.qty;
  //   });

  //   return total;
  // }
}

class OrderButton extends StatefulWidget {
  final Cart cart;

  OrderButton({@required this.cart});

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(OrderScreen.route);
      },
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(AppLocale.of(context).getString("orderNow")),
      style: TextButton.styleFrom(
        primary: Theme.of(context).primaryColor,
      ),
    );
  }
}
