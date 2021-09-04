import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/components.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/style.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/product_details_data.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ViewAvailableImageDetailsScreen extends StatefulWidget {
  static const String route = "/view_available_image_details";
  final int index;

  const ViewAvailableImageDetailsScreen({Key? key, required this.index})
      : super(key: key);
  @override
  _ViewAvailableImageDetailsScreenState createState() =>
      _ViewAvailableImageDetailsScreenState();
}

class _ViewAvailableImageDetailsScreenState
    extends State<ViewAvailableImageDetailsScreen> {
  int quantity = 1;
  late String locale;
  // late bool? isFavourite;
  @override
  void initState() {
    super.initState();
    locale = CacheHelper.getPrefs(key: "locale") ?? "ar";
  }

  @override
  Widget build(BuildContext context) {
    // final productId = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;

    ProductDetailsData? productDetails =
        Provider.of<ProductProvider>(context).productData;
    final product = productDetails!.avilabeProductGalleries![widget.index];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: primaryColor,
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
      ),
      body: productDetails == null
          ? Center(
              child: const SpinKitChasingDots(
                color: Color(0XFFE5A352),
              ),
            )
          : Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: InteractiveViewer(
                      child: Image.network(
                        Constants.imagePath +
                            productDetails
                                .avilabeProductGalleries![widget.index]
                                .imagePath
                                .toString(),
                      ),
                    ),
                  ),
                  Text(
                    locale == "ar"
                        ? product.textAr ?? ""
                        : product.textEn ??
                            productDetails
                                .avilabeProductGalleries![widget.index].textAr,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200]!,
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 1))
                            ]),
                        child: IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.minus,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (quantity == 0 || quantity < 0)
                              setState(() {
                                quantity = 0;
                              });
                            else if (quantity > 0)
                              setState(() {
                                // print(quantity);
                                quantity--;
                              });
                            // print(quantity);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "$quantity",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200]!,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 1))
                            ]),
                        child: IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (quantity >= 0)
                              setState(() {
                                quantity++;
                              });
                            // else if (quantity == 0 || quantity < 0)
                            //   setState(() {
                            //     quantity = 0;
                            //   });
                            // print(quantity);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (quantity > 0) {
                        addToCart(
                          quantity,
                          product.productId,
                          locale == "ar"
                              ? product.textAr ?? ""
                              : product.textEn ??
                                  productDetails
                                      .avilabeProductGalleries![widget.index]
                                      .textAr,
                        );
                      } else {
                        showToast(
                            text: getString(context, "quantityError"),
                            bgColor: hintColor);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).primaryColor),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Text(
                              AppLocale.of(context)!.getString("total")! +
                                  " ${quantity * productDetails.price!}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: const EdgeInsets.all(3),
                              child: Text(
                                AppLocale.of(context)!
                                    .getString("add_to_cart")!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.shopping_basket,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void addToCart(int quantity, int? id, String? description) async {
    Provider.of<Cart>(context, listen: false)
        .addItemToCart(id, quantity, description)
        .then((value) {
      print(value);
      if (value == "done") {
        Provider.of<Cart>(context, listen: false).fetchCartList();
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: Text(AppLocale.of(context)!.getString("addedSuccess")!)));
        showToast(
          text: getString(context, "addedSuccess"),
          bgColor: errorColor,
        );
      } else if (value == "auth") {
        Provider.of<Auth>(context).logout();
        Navigator.pushNamedAndRemoveUntil(
            context, Login.route, (Route<dynamic> route) => false);
      } else {
        showToast(
          text: getString(context, "addedError"),
          bgColor: errorColor,
        );
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: Text(AppLocale.of(context)!.getString("addedError")!)));
      }
    }).catchError((e) {
      showToast(
        text: getString(context, "addedError"),
        bgColor: errorColor,
      );
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text(AppLocale.of(context)!.getString("addedError")!)));
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
