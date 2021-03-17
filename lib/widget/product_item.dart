import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/product_data.dart';
import 'package:flutter/material.dart';

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
      height: MediaQuery.of(context).size.height - 50.0,
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0, left: 5.0),
        child: InkWell(
          onTap: () {},
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
                  padding: EdgeInsets.all(7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _displayTextInputDialog(context);
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
                    height: 75.0,
                    width: 75.0,
                    child: CachedNetworkImage(
                      imageUrl: "http://eshop5827-001-site3.etempurl.com" +
                          widget.product.imagePath,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(height: 7.0),
                Text(
                  '${widget.product.price}',
                  style: TextStyle(color: Color(0xFFCC8053), fontSize: 15.0),
                ),
                Text(
                  widget.product.name,
                  style: TextStyle(
                      color: Color(0xFF575E67),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
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

                icon: Icon(Icons.shopping_cart,),
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
}
