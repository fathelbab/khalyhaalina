import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
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
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocale.of(context)!.getString('cart')!,
        ),
      ),
      body: cart.cartItems == null || cart.cartItems!.isEmpty
          ? Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_rounded,
                    size: 150,
                    color: Colors.grey,
                  ),
                  Text(
                    'السلة فارغة',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    child: Text(
                      'مواصلة التسوق',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            )
          : Column(
              children: [
                Card(
                  margin: EdgeInsets.all(15.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocale.of(context)!.getString("total")!,
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
                    itemCount: cart.cartItems!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CartItem(
                        productId: cart.cartItems![index].productid.toString(),
                        price: cart.cartItems![index].price,
                        quantity: cart.cartItems![index].qty,
                        title: cart.cartItems![index].name,
                        image: cart.cartItems![index].image,
                        id: cart.cartItems![index].id,
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

  OrderButton({required this.cart});

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // if (Provider.of<Cart>(context).cartItems.isNotEmpty)
        Navigator.of(context).pushNamed(OrderScreen.route);
      },
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(AppLocale.of(context)!.getString("orderNow")!),
      style: TextButton.styleFrom(
        primary: Theme.of(context).primaryColor,
      ),
    );
  }
}
