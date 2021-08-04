import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/screen/product_details/product_details_screen.dart';
import 'package:eshop/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProductItems extends StatefulWidget {
  final Product product;
  final int index;

  ProductItems({
    required this.product,
    required this.index,
  });

  @override
  _ProductItemsState createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems> {
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int productDiscount =
        getDiscount(widget.product.price, widget.product.oldPrice);
    return InkWell(
      onTap: () {
        Provider.of<ProductProvider>(context, listen: false).clearProductData();

        Provider.of<ProductProvider>(context, listen: false)
            .getProductById(widget.product.id);
        Navigator.of(context).pushNamed(
          ProductDetailsScreen.route,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
              Expanded(
                flex: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: widget.product.id!,
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl:
                              Constants.imagePath + widget.product.imagePath!,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Center(
                            child: const SpinKitChasingDots(
                                color: Color(0XFFE5A352)),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 1,
                      left: 1,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // _displayTextInputDialog(context);
                            },
                            icon: Icon(
                              Icons.favorite_outline,
                              size: 30,
                            ),
                            color: secondaryColor,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share,
                              size: 30,
                            ),
                            color: secondaryColor,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 1,
                      right: 1,
                      child: productDiscount != 0
                          ? Container(
                              padding: const EdgeInsets.only(
                                  right: 10, left: 10, top: 5, bottom: 5),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(0xFFF8973D),
                                shape: BoxShape.rectangle,
                              ),
                              child: Text(
                                "${productDiscount.toString()} %",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
              Text(
                widget.product.nameAr!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF575E67),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              // SizedBox(height: 3.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${widget.product.price}ج.م',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // if (widget.product.oldPrice != widget.product.price)
                  Text(
                    '${widget.product.oldPrice}ج.م',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }

  void addToCart(int quantity, int? id) async {
    Provider.of<Cart>(context, listen: false)
        .addItemToCart(id, quantity)
        .then((value) {
      print(value);
      if (value == "done") {
        Provider.of<Cart>(context, listen: false).fetchCartList();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocale.of(context)!.getString("addedSuccess")!)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocale.of(context)!.getString("addedError")!)));
      }
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocale.of(context)!.getString("addedError")!)));
    });
  }

  int getDiscount(double? price, double? oldPrice) {
    double discount = oldPrice! - price!;
    if (price == oldPrice) {
      return 0;
    } else {
      double discountPercent = discount.abs() / oldPrice * 100;

      return discountPercent.toInt();
    }
  }
}
