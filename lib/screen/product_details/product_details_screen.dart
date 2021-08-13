import 'package:eshop/utils/style.dart';
import 'package:eshop/language/app_locale.dart';
import 'package:eshop/model/product_details_data.dart';
import 'package:eshop/provider/auth_provider.dart';
import 'package:eshop/provider/cart.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/screen/cart/cart_screen.dart';
import 'package:eshop/screen/login/login.dart';
import 'package:eshop/screen/search/search_screen.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/widget/badge.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class ProductDetailsScreen extends StatefulWidget {
  static const String route = "/product_details_screen";

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    // final productId = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    ProductDetailsData? productDetails =
        Provider.of<ProductProvider>(context).productData;
    // print(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productDetails?.name != null ? productDetails!.name.toString() : "",
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
      body: productDetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          productDetails.productGalleries != null &&
                                  productDetails.productGalleries!.isEmpty
                              ? Hero(
                                  tag: productDetails.id!,
                                  child: Image.network(
                                   Constants. imagePath + productDetails.imagePath!,
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                    height: size.height / 3 + 50,
                                  ),
                                )
                              : Hero(
                                  tag: productDetails.id!,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3 +
                                            50,
                                    width: MediaQuery.of(context).size.width,
                                    child: CarouselSlider.builder(
                                      itemCount: productDetails
                                          .productGalleries!.length,
                                      itemBuilder: (BuildContext context,
                                          int index, int realIndex) {
                                        return sliderBuilder(index,
                                            productDetails.productGalleries!);
                                      },
                                      // items: imageSliders,
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        enableInfiniteScroll: true,
                                        aspectRatio: 1.0,
                                        disableCenter: false,
                                        enlargeCenterPage: true,
                                        // enlargeStrategy: CenterPageEnlargeStrategy.height,
                                      ),
                                    ),
                                  ),
                                ),
                          Text(
                            productDetails.name ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              // fontFamily: 'Anton',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${productDetails.price ?? 0.0} ج.م",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Theme.of(context).errorColor),
                              ),
                              productDetails.price == productDetails.oldPrice
                                  ? Text('')
                                  : Text(
                                      "${productDetails.oldPrice ?? 0.0} ج.م",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Theme.of(context).errorColor),
                                    ),
                            ],
                          ),
                          Text(
                            productDetails.description ?? "",
                            maxLines: 6,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildQuantityIncrementer(),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (quantity > 0) {
                        addToCart(quantity, productDetails.id);
                      } else {}
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

  Row buildQuantityIncrementer() {
    return Row(
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
                  print(quantity);
                  quantity--;
                });
              print(quantity);
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
              print(quantity);
            },
          ),
        ),
      ],
    );
  }

  Container sliderBuilder(int index, List<ProductGallery> productGalleries) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(Constants.imagePath + productGalleries[index].imagePath!,
                  fit: BoxFit.contain, width: double.infinity),
              // Positioned(
              //   bottom: 0.0,
              //   left: 0.0,
              //   right: 0.0,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: [
              //           Color.fromARGB(200, 0, 0, 0),
              //           Color.fromARGB(0, 0, 0, 0)
              //  ,       ],
              //         begin: Alignment.bottomCenter,
              //         end: Alignment.topCenter,
              //       )
              //     ),
              //     padding:
              //         EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              //     child: Text(
              //       'No. $index image',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 20.0,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          )),
    );
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
      } else if (value == "auth") {
        Provider.of<Auth>(context).logout();
        Navigator.pushNamedAndRemoveUntil(
            context, Login.route, (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocale.of(context)!.getString("addedError")!)));
      }
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocale.of(context)!.getString("addedError")!)));
    });
  }
}
