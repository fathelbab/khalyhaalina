import 'package:eshop/model/product_data.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class SearchResultListView extends StatelessWidget {
  final String searchTerm;
  List<Product> productList = [];

  SearchResultListView({this.searchTerm});
  @override
  Widget build(BuildContext context) {
    productList = Provider.of<ProductProvider>(context).searchProductList;
    return Container(
      padding: EdgeInsets.only(
        right: 5,
        left: 5,
        bottom: 5,
      ),
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
    );
  }
  
}
