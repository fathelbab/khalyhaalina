import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop/model/main_category.dart';
import 'package:eshop/model/supplier_data.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/provider/supplier_provider.dart';
import 'package:eshop/screen/cart/cart_screen.dart';
import 'package:eshop/screen/search/search_screen.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/widget/badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../product_screen.dart';

class SupplierScreen extends StatefulWidget {
  static const String route = "/supplier";

  const SupplierScreen({Key? key}) : super(key: key);

  @override
  _SupplierScreenState createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  bool isLoading = false;
  int selecteIndex = 0;
  late String locale;
  List<Supplier>? supplierList = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    locale = CacheHelper.getPrefs(key: "locale") ?? "ar";
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    var supplierProvider = Provider.of<SupplierProvider>(context);
    final MainCategory mainCategory =
        ModalRoute.of(context)!.settings.arguments as MainCategory;
    supplierList = supplierProvider.supplierList;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          locale == "ar"
              ? mainCategory.nameAr.toString()
              : mainCategory.nameEn.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).pushNamed(SearchScreen.route);
              }),
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
            height: MediaQuery.of(context).size.height / 4,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: Constants.imagePath + mainCategory.image2.toString(),
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  Center(
                    child: const SpinKitChasingDots(
                        color: Color(0XFFE5A352)),
                  ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            color: primaryColor,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: mainCategory.subCategory!.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  supplierProvider
                      .fetchSupplierList(
                          mainCategory.subCategory![index].id.toString(), 1, 20)
                      .then((value) {
                    setState(() {
                      isLoading = false;
                    });
                  });
                  setState(() {
                    isLoading = true;
                    selecteIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: selecteIndex == index
                              ? secondaryColor
                              : Colors.grey,
                          width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      locale == "ar"
                          ? mainCategory.subCategory![index].nameAr.toString()
                          : mainCategory.subCategory![index].nameEn.toString(),
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
          supplierList == null || supplierList!.isEmpty
              ? Text("")
              : Expanded(
                  child: !isLoading
                      ? LayoutBuilder(
                          builder: (context, constraints) {
                            return GridView.builder(
                              controller: scrollController,
                              padding: const EdgeInsets.all(8),
                              itemCount: supplierList!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                                crossAxisCount:
                                    constraints.maxWidth > 480 ? 4 : 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // print("object");
                                    productProvider.clearProductList();
                                    supplierProvider.clearSuppliertList();

                                    supplierProvider.getSupplierCategory(
                                        supplierList![index].id.toString(),
                                        200);

                                    productProvider.clearProductList();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                          supplierId: supplierList![index]
                                              .id
                                              .toString(),
                                          supplierImage: supplierList![index]
                                              .imagePath
                                              .toString(),
                                          supplierName: locale == "ar"
                                              ? supplierList![index]
                                                  .nameAr
                                                  .toString()
                                              : supplierList![index].nameEn ??
                                                  "",
                                        ),
                                      ),
                                    );
                                    // print(limit);
                                    // Navigator.pushNamed(
                                    //     context, ProductScreen.route,
                                    //     arguments: {
                                    //       "supplierId": supplierList![index]
                                    //           .id
                                    //           .toString(),
                                    //       "supplierImage": supplierList![index]
                                    //           .imagePath
                                    //           .toString(),
                                    //       "supplierName": locale == "ar"
                                    //           ? supplierList![index]
                                    //               .nameAr
                                    //               .toString()
                                    //           : supplierList![index].nameEn ??
                                    //               "",
                                    //     });
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: CachedNetworkImage(
                                            imageUrl: Constants.imagePath +
                                                supplierList![index].imagePath!,
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: const SpinKitChasingDots(
                                                color: Color(0XFFE5A352),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          locale == "ar"
                                              ? supplierList![index]
                                                  .nameAr
                                                  .toString()
                                              : supplierList![index]
                                                  .nameEn
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 5, left: 5),
                                          margin: const EdgeInsets.all(5),
                                          width: constraints.maxWidth,
                                          decoration: BoxDecoration(
                                            color: getSupplierState(
                                                        context,
                                                        supplierList![index]
                                                            .closeTime) ==
                                                    getString(context, 'open')
                                                ? Colors.greenAccent
                                                : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              getSupplierState(
                                                  context,
                                                  supplierList![index]
                                                      .closeTime),
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: getSupplierState(
                                                            context,
                                                            supplierList![index]
                                                                .closeTime) ==
                                                        getString(
                                                            context, 'open')
                                                    ? primaryColor
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : Center(
                          child: const SpinKitChasingDots(
                            color: Color(0XFFE5A352),
                          ),
                        ),
                )
        ],
      ),
    );
  }

  String getSupplierState(BuildContext context, String? closeTime) {
    var now = DateFormat.jms('en').format(DateTime.now()).compareTo(closeTime!);
    // Log.w(now.toString());
    // Log.e(closeTime.toString());
    // Log.e(DateFormat.jms(
    //   'es',
    // ).format(DateTime.now()).toString());
    if (now.isNegative) {
      return getString(context, "close");
    } else {
      return getString(context, "open");
    }
  }
}
