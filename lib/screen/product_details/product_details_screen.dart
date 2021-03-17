import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String route = "/product_details_screen";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;

    // final productProvider = Provider.of<ProductProvider>(context, listen: false)
    //     .getProductById(productId);

    print(productId);
    return Column(
      children: [
        Text("$productId"),
        Text("خليها علينا"),
      ],
    );
  }
}
