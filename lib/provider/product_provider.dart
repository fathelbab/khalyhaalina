import 'dart:core';

import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/model/product_details_data.dart';
import 'package:flutter/widgets.dart';

class ProductProvider extends ChangeNotifier {
  List<Product>? _productList = [];
  List<Product>? _productHotList = [];
  List<Product>? _searchProductList = [];
  ProductDetailsData? _productData;
  fetchProductList(String? supplierId, String? categoryId, String searchTerm,
      int offset, int limit) async {
    print(searchTerm);
    _productList = await (fetchProduct(
      supplierId,
      categoryId,
      searchTerm,
      offset,
      limit,
    ) );
    notifyListeners();
  }

  fetchProductHotList(
      String supplierId, String categoryId, int offset, int limit) async {
    _productHotList = await (fetchProductHot(
      supplierId,
      categoryId,
      offset,
      limit,
    ) );
    notifyListeners();
  }

  search(String? searchTerm, int offset, int limit) async {
    _searchProductList = await (searchWithTerm(
      searchTerm,
      offset,
      limit,
    ) );
    print(_searchProductList!.length);
    notifyListeners();
  }

  getProductById(int? productId) async {
    _productData = await fetchProductById(productId);

    notifyListeners();
  }

  clearProductList() {
    _productList!.clear();
    notifyListeners();
  }
clearProductData() {
    _productData=null;
    notifyListeners();
  }

  ProductDetailsData? get productData => _productData;

  List<Product>? get productList => _productList;
  List<Product>? get productHotList => _productHotList;
  List<Product>? get searchProductList => _searchProductList;
}
