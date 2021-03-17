import 'dart:core';

import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/product_data.dart';
import 'package:flutter/widgets.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _productList = [];
  List<Product> _searchProductList = [];
  Product _productData;
  fetchProductList(
      String supplierId, String categoryId, int offset, int limit) async {
    _productList = await fetchProduct(
      supplierId,
      categoryId,
      offset,
      limit,
    );
    notifyListeners();
  }

  search(String searchTerm, int offset, int limit) async {
    _searchProductList = await searchWithTerm(
    searchTerm,
      offset,
      limit,
    );
    print(_searchProductList.length);
    notifyListeners();
  }

  getProductById(int productId) async {
    _productData = await fetchProductById(productId);
    notifyListeners();
  }

  Product get productData => _productData;

  List<Product> get productList => _productList;
  List<Product> get searchProductList => _searchProductList;
}
