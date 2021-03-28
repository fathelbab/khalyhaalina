import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/screen/product_details/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItems extends StatefulWidget {
  final Product product;
  final int index;

  ProductItems({
    @required this.product,
    @required this.index,
  });

  @override
  _ProductItemsState createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems> {
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30.0,
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0, left: 5.0),
        child: InkWell(
          onTap: () {
            Provider.of<ProductProvider>(context, listen: false)
                .getProductById(widget.product.id);
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.route,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            // _displayTextInputDialog(context);
                            addToCart(1, widget.product.id);
                          },
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                ),
                Hero(
                  tag: widget.product.id,
                  child: Container(
                    height: 70.0,
                    width: 60.0,
                    child: CachedNetworkImage(
                      imageUrl: imagePath + widget.product.imagePath,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '${widget.product.price}ج.م',
                  style: TextStyle(color: Color(0xFFCC8053), fontSize: 12.0),
                ),
                Text(
                  widget.product.name,
                  style: TextStyle(
                      color: Color(0xFF575E67),
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                  hintText:
                      AppLocale.of(context).getString('quantity_message')),
            ),
            actions: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: Text(AppLocale.of(context).getString("add_to_cart")),
                style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                onPressed: () {
                  print(_textFieldController.text.toString());
                  _textFieldController.clear();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(AppLocale.of(context).getString("cancel")),
                style: TextButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  print(_textFieldController.text.toString());
                  _textFieldController.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }
   void addToCart(int quantity, int id) async {
    Provider.of<Cart>(context, listen: false)
        .addItemToCart(id, quantity)
        .then((value) {
      print(value);
      if (value == "done") {
        Provider.of<Cart>(context, listen: false).fetchCartList();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocale.of(context).getString("addedSuccess"))));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocale.of(context).getString("addedError"))));
      }
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocale.of(context).getString("addedError"))));
    });
  }
}
