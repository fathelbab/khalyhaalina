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
  List<Product> productList = [];
  String supplierId = "0";
  String categoryId = "0";
  int limit = 20;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments as Map;
    supplierId = args["supplierId"];
    loadProduct(supplierId, categoryId, context);
    productList = Provider.of<ProductProvider>(context).productList;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.of(context).getString('product')),
        centerTitle: true,
        actions: [
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
                value: cart.cartItems != null && cart.cartItems.length > 0
                  ? cart.cartItems.length.toString()
                  : "0.0",
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
      body: Container(
        padding: EdgeInsets.all(10),
        child: productList == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : productList.length == 0
                ? Center(child: Text('No Products Found'))
                : GridView.builder(
                    itemCount: productList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return ProductItems(
                          product: productList[index], index: index);
                    }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _categoryScrollController.dispose();
  }

  void loadProduct(String supplierId, String categoryId, BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false)
        .fetchProductList(supplierId, categoryId, 1, limit);

    // print(id);
  }
  
}

// class ProductItems extends StatelessWidget {
//   final Product product;
//   final int index;
//   ProductItems({
//     @required this.product,
//     @required this.index,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         print("id= " + product.id.toString());

//         Navigator.of(context).pushNamed(
//           ProductDetailsScreen.route,
//           arguments: product.id,
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: Colors.amber,
//         ),
//         child: Stack(
//           children: [
//             Center(
//               child: CachedNetworkImage(
//                 imageUrl: "http://eshop5827-001-site3.etempurl.com" +
//                     product.imagePath,
//                 fit: BoxFit.fill,
//                 placeholder: (context, url) =>
//                     Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               left: 0,
//               child: Container(
//                   alignment: Alignment.center,
//                   color: Colors.black.withOpacity(0.5),
//                   child: Text(
//                     product.name,
//                     style: TextStyle(color: Colors.white),
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
