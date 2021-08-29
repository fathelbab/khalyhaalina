import 'package:eshop/screen/online_support/online_support_screen.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/style.dart';
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
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        OnlineSupportScreen.route,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    child: Text(
                      getString(context, "onlineSupport"),
                      style: TextStyle(
                        fontSize: 18,
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
                  margin: EdgeInsets.only(
                      top: 15.0, right: 15, left: 15, bottom: 5),
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
                MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, OnlineSupportScreen.route);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          getString(context, "moreOrder"),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: cart.cartItems!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CartItem(
                        productId: cart.cartItems![index].productid,
                        price: cart.cartItems![index].price,
                        quantity: cart.cartItems![index].qty,
                        title: cart.cartItems![index].name,
                        image: cart.cartItems![index].image,
                        id: cart.cartItems![index].id,
                        description: cart.cartItems![index].description ?? "",
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
        Provider.of<Cart>(context, listen: false).fetchCartList();
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
