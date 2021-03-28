import 'package:eshop/language/app_locale.dart';
import 'package:eshop/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItem({
    this.productId,
    this.price,
    this.quantity,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(productId),
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
            title: Text('Alert!'),
            content: Text('Are you sure delete this product?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItems(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: FittedBox(
                child: Text(
                  'ج.م $price ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            title: Text(title),
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
