import 'package:eshop/model/FavouriteProduct.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/style.dart';
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _favouriteProductList == null
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
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
                    return Column(
                      children: [
                        Text(_favouriteProductList![index].nameAr.toString()),
                        Text(_favouriteProductList![index].price.toString()),
                      ],
                    );
                  });
        },
      ),
    );
  }
}
