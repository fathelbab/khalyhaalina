import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/model/supplier_category.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/widget/badge.dart';
import 'package:eshop/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'cart/cart_screen.dart';

class ProductScreen extends StatefulWidget {
  static const String route = "/product_screen";
  final String? supplierId;

  final String? supplierName;
  final String? supplierImage;

  const ProductScreen(
      {Key? key, this.supplierId, this.supplierName, this.supplierImage})
      : super(key: key);
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product>? _productList = [];
  // String? supplierId = "0";

  // String? supplierName = "";
  // String? supplierImage = "";
  int limit = 20;
  final _searchController = TextEditingController();
  ScrollController _productScrollController = new ScrollController();
  bool isLoading = true;
  int mainCategorySelectedIndex = -1;
  int subCategorySelectedIndex = -1;
  late String locale;
  List<Category>? _supplierMainCategory;
  List<Category>? _supplierSubCategory;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false)
        .fetchProductList(widget.supplierId, "0", "", 1, 20)
        .then((value) {
      // print("ssssssssssssssssssssssssssssssssssssssssssssssss");
      setState(() {
        isLoading = false;
      });
    });
    locale = CacheHelper.getPrefs(key: "locale") ?? "ar";
    _productScrollController.addListener(() {
      if (_productScrollController.position.pixels ==
          _productScrollController.position.maxScrollExtent) {
        // print(limit);

        limit += 20;
        // print("kira =============== $categoryId");
        Provider.of<ProductProvider>(context, listen: false)
            .fetchProductList(widget.supplierId, "", "", 1, limit);
        // print(limit);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Map args = ModalRoute.of(context)!.settings.arguments as Map;
    // supplierId = args["supplierId"];
    // supplierName = args["supplierName"];
    // supplierImage = args["supplierImage"];
    var productProvider = Provider.of<ProductProvider>(context);
    var supplierProvider = Provider.of<SupplierProvider>(context);
    _supplierMainCategory = supplierProvider.supplierMainCategory;
    _supplierSubCategory = supplierProvider.supplierSubCategory;
    _productList = productProvider.productList;

    // print("kira$supplierImage");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.supplierName ?? "",
          style: TextStyle(fontSize: 20),
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
      body: Column(
        children: [
          if (widget.supplierImage != null)
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: Constants.imagePath + widget.supplierImage!,
                fit: BoxFit.fill,
                placeholder: (context, url) => Center(
                  child: const SpinKitChasingDots(color: Color(0XFFE5A352)),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          if (_supplierMainCategory != null &&
              _supplierMainCategory!.isNotEmpty)
            Container(
              width: double.infinity,
              height: 50,
              color: primaryColor,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _supplierMainCategory!.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Provider.of<SupplierProvider>(context, listen: false)
                        .setSubCategory(_supplierMainCategory![index].id!);
                    Provider.of<ProductProvider>(context, listen: false)
                        .fetchProductList(
                            widget.supplierId,
                            _supplierMainCategory![index].id.toString(),
                            "",
                            1,
                            limit)
                        .then((value) {
                      setState(() {
                        isLoading = false;
                      });
                    });
                    setState(() {
                      isLoading = true;
                      mainCategorySelectedIndex = index;
                      subCategorySelectedIndex = -1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: mainCategorySelectedIndex == index
                                ? secondaryColor
                                : Colors.grey,
                            width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        _supplierMainCategory![index].name.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (_supplierSubCategory != null && _supplierSubCategory!.isNotEmpty)
            Container(
              width: double.infinity,
              height: 50,
              color: primaryColor,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _supplierSubCategory!.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .fetchProductList(
                            widget.supplierId,
                            _supplierSubCategory![index].id.toString(),
                            "",
                            1,
                            limit)
                        .then((value) {
                      setState(() {
                        isLoading = false;
                      });
                    });

                    setState(() {
                      subCategorySelectedIndex = index;
                      isLoading = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: subCategorySelectedIndex == index
                                ? secondaryColor
                                : Colors.grey,
                            width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        _supplierSubCategory![index].name.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: isLoading
                  ? Center(
                      child: const SpinKitChasingDots(color: Color(0XFFE5A352)),
                    )
                  : _productList == null || _productList!.length == 0
                      ? Center(
                          child: Text(
                            getString(context, "noProductAvailable"),
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      // ? Center(
                      //     child: CircularProgressIndicator(),
                      //   )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            return GridView.builder(
                                controller: _productScrollController,
                                itemCount: _productList!.length,
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
                                      product: _productList![index],
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
