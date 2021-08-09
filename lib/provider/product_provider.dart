import 'dart:core';

import 'package:eshop/data/service/product_service.dart';
import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/FavouriteProduct.dart';
import 'package:eshop/model/product_data.dart';
import 'package:eshop/model/product_details_data.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:flutter/widgets.dart';

class ProductProvider extends ChangeNotifier {
  List<Product>? _productList = [];
  List<Product>? _productHotList = [];
  List<Product>? _searchProductList = [];
  List<FavouriteProduct>? _favouriteProducts = [];
  ProductDetailsData? _productData;
  String currentCategoryId = "0";

  fetchProductList(String? supplierId, String? categoryId, String searchTerm,
      int offset, int limit) async {
    print(currentCategoryId);
    // currentCategoryId = categoryId!;
    print(currentCategoryId);
    if (categoryId!.isEmpty)
      categoryId = currentCategoryId;
    else
      currentCategoryId = categoryId;
    _productList = await (fetchProduct(
      supplierId,
      categoryId,
      searchTerm,
      offset,
      limit,
    ));
    notifyListeners();
  }

  fetchProductHotList(
      String supplierId, String categoryId, int offset, int limit) async {
    String cityId = CacheHelper.getPrefs(key: 'cityId');
    _productHotList = await (fetchProductHot(
      supplierId,
      cityId,
      categoryId,
      offset,
      limit,
    ));
    notifyListeners();
  }

  search(String? searchTerm, int offset, int limit) async {
    _searchProductList = await (searchWithTerm(
      searchTerm,
      offset,
      limit,
    ));
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
    _productData = null;
    notifyListeners();
  }

  addProductToFavourite(String? productId) async {
    String accessToken = CacheHelper.getPrefs(key: 'token');
    print(accessToken);
    await addFavouriteProduct(accessToken, productId!);
  }

  getFavouriteProducts() async {
    String accessToken = CacheHelper.getPrefs(key: 'token');
    print(accessToken);
    _favouriteProducts = await getAllFavouriteProducts(accessToken);
    notifyListeners();
  }

  ProductDetailsData? get productData => _productData;

  List<Product>? get productList => _productList;

  List<FavouriteProduct>? get favouriteProducts => _favouriteProducts;

  List<Product>? get productHotList => _productHotList;

  List<Product>? get searchProductList => _searchProductList;
}
