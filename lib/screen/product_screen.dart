import 'package:eshop/constant/constant.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/widget/badge.dart';
import 'package:eshop/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart/cart_screen.dart';

class ProductScreen extends StatefulWidget {
  static const String route = "/product_screen";

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product>? productList = [];
  String? supplierId = "0";
  String? categoryId = "0";
  String? supplierName = "";
  int limit = 20;
  final _searchController = TextEditingController();
  ScrollController _productScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _productScrollController.addListener(() {
      if (_productScrollController.position.pixels ==
          _productScrollController.position.maxScrollExtent) {
        print(limit);

        limit += 20;
        Provider.of<ProductProvider>(context, listen: false)
            .fetchProductList(supplierId, categoryId, "", 1, limit);
        print(limit);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    supplierId = args["supplierId"];
    categoryId = args["categoryId"];
    supplierName = args["supplierName"];
    productList = Provider.of<ProductProvider>(context).productList;
    return Scaffold(
      appBar: AppBar(
        title: Text(supplierName != null
            ? supplierName.toString()
            : AppLocale.of(context)!.getString('product')!),
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15, left: 15, top: 5),
            padding: const EdgeInsets.only(right: 10, left: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: kElevationToShadow[6]),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      child: TextField(
                    controller: _searchController,
                    onSubmitted: (value) {
                      print(value);
                      Provider.of<ProductProvider>(context, listen: false)
                          .fetchProductList(
                              supplierId, categoryId, value, 1, limit);
                    },
                    decoration: InputDecoration(
                        hintText: 'البحث',
                        hintStyle: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                        border: InputBorder.none),
                  )),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.close,
                          // isSearch ? Icons.close : Icons.search,
                          color: primaryColor,
                        ),
                      ),
                      onTap: () {
                        print(_searchController.text);
                        if (_searchController.text.isNotEmpty) {
                          _searchController.clear();
                          Provider.of<ProductProvider>(context, listen: false)
                              .fetchProductList(
                                  supplierId, categoryId, "", 1, limit);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: productList == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : productList!.length == 0
                      // ? Center(child: Text('لايوجد منتجات متاحة'))
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            return GridView.builder(
                                controller: _productScrollController,
                                itemCount: productList!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                  crossAxisCount:
                                      constraints.maxWidth > 480 ? 4 : 2,
                                  childAspectRatio: 0.8,
                                ),
                                itemBuilder: (context, index) {
                                  return ProductItems(
                                      product: productList![index],
                                      index: index);
                                });
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _productScrollController.dispose();
    _searchController.dispose();
  }
}
