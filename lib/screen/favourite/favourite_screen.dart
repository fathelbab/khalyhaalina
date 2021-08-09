import 'package:eshop/model/FavouriteProduct.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  static const String route = "/favourite_screen";

  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<FavouriteProduct>? _favouriteProductList = [];

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getFavouriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    _favouriteProductList =
        Provider.of<ProductProvider>(context).favouriteProducts;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _favouriteProductList == null
              ? Text("")
              : GridView.builder(
                  // controller: _productScrollController,
                  itemCount: _favouriteProductList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    crossAxisCount: constraints.maxWidth > 480 ? 4 : 2,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return Text(_favouriteProductList![index]
                        .product!
                        .nameAr
                        .toString());
                  });
        },
      ),
    );
  }
}
