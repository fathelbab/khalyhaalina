import 'package:eshop/model/FavouriteProduct.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/screen/cart/cart_screen.dart';
import 'package:eshop/screen/online_support/online_support_screen.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/widget/badge.dart';
import 'package:eshop/widget/favourite_product_item.dart';
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
  late String locale;

  @override
  void initState() {
    super.initState();
    locale = CacheHelper.getPrefs(key: "locale") ?? "ar";
    Provider.of<ProductProvider>(context, listen: false).getFavouriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    _favouriteProductList =
        Provider.of<ProductProvider>(context).favouriteProducts;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          getString(context, "favourite"),
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              value: cart.cartItems != null && cart.cartItems!.length > 0
                  ? cart.cartItems!.length.toString()
                  : "0",
              child: child,
              color: Colors.red,
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.route);
                }),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _favouriteProductList == null || _favouriteProductList!.isEmpty
              ? Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 150,
                        color: Colors.grey,
                      ),
                      Text(
                        getString(context, "emptyFavourite"),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
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
              : Container(
                  margin: const EdgeInsets.all(5),
                  child: GridView.builder(
                      // controller: _productScrollController,
                      itemCount: _favouriteProductList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        crossAxisCount: constraints.maxWidth > 480 ? 4 : 2,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        return FavouriteProductItem(
                            product: _favouriteProductList![index],
                            index: index);
                      }),
                );
        },
      ),
    );
  }
}
