import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final int id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String image;

  const CartItem({
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (cxt) => AlertDialog(
            // title: Text(AppLocale.of(context).getString("alert")),
            content: Text(AppLocale.of(context).getString("alertBody")),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocale.of(context).getString("no")),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Provider.of<Cart>(context, listen: false)
                      .removeItems(id.toString());
                  Provider.of<Cart>(context, listen: false).fetchCartList();
                },
                child: Text(AppLocale.of(context).getString("yes")),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItems(id.toString());
        Provider.of<Cart>(context, listen: false).fetchCartList();
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
            leading: ClipRRect(
              child: FittedBox(
                child: CachedNetworkImage(
                  imageUrl: imagePath + image,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 13),
            ),
            subtitle: Text(
                '${AppLocale.of(context).getString("total")} ${price * quantity} ج.م'),
            trailing: Text(
                '${AppLocale.of(context).getString("quantity")} : $quantity '),
          ),
        ),
      ),
    );
  }
}
  // leading: CircleAvatar(
  //             backgroundColor: Theme.of(context).primaryColor,
  //             child: FittedBox(
  //               child: Text(
  //                 'ج.م $price ',
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ),