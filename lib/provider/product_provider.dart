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
  List<Product>? _discountHotProductList = [];
  List<Product>? _newHotProductList = [];
  List<Product>? _statusHotProductList = [];
  List<Product>? _searchProductList = [];
  List<FavouriteProduct>? _favouriteProducts = [];
  ProductDetailsData? _productData;
  String currentCategoryId = "0";

  fetchProductList(String? supplierId, String? categoryId, String searchTerm,
      int offset, int limit) async {
    String accessToken = CacheHelper.getPrefs(key: 'token');
    if (categoryId!.isEmpty)
      categoryId = currentCategoryId;
    else
      currentCategoryId = categoryId;
    _productList = await (fetchProduct(
      accessToken,
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
    String accessToken = CacheHelper.getPrefs(key: 'token');
    _productHotList = await (fetchProductHot(
      accessToken,
      supplierId,
      cityId,
      categoryId,
      offset,
      limit,
    ));
    _discountHotProductList = _productHotList!
        .where((product) => product.discountProduct != null)
        .toList();
    _statusHotProductList = _productHotList!
        .where((product) => product.stutesProduct != null)
        .toList();
    _newHotProductList = _productHotList!
        .where((product) => product.discountProduct != null)
        .toList();
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
    await addFavouriteProduct(accessToken, productId!);
    _productHotList?.map((product) {
      if (product.id.toString() == productId) {
        product.isFavority = true;
      }
    }).toList();
    _discountHotProductList = _productHotList!
        .where((product) => product.discountProduct != null)
        .toList();
    _statusHotProductList = _productHotList!
        .where((product) => product.stutesProduct != null)
        .toList();
    _newHotProductList = _productHotList!
        .where((product) => product.discountProduct != null)
        .toList();
    _productList?.map((product) {
      if (product.id.toString() == productId) {
        product.isFavority = true;
      }
    }).toList();
    notifyListeners();
  }

  removeProductFromFavourite(String? productId) async {
    String accessToken = CacheHelper.getPrefs(key: 'token');
    await removeFavouriteProduct(accessToken, productId!);
    _productHotList?.map((product) {
      if (product.id.toString() == productId) {
        product.isFavority = false;
        // addProductToFavourite(productId);

      }
    }).toList();
    _favouriteProducts
        ?.removeWhere((product) => product.id.toString() == productId);
    _discountHotProductList = _productHotList!
        .where((product) => product.discountProduct != null)
        .toList();
    _statusHotProductList = _productHotList!
        .where((product) => product.stutesProduct != null)
        .toList();
    _newHotProductList = _productHotList!
        .where((product) => product.discountProduct != null)
        .toList();
    _productList?.map((product) {
      if (product.id.toString() == productId) {
        product.isFavority = false;
      }
    }).toList();
    notifyListeners();
  }

  getFavouriteProducts() async {
    String accessToken = CacheHelper.getPrefs(key: 'token');
    print(accessToken + "dfsafa");
    _favouriteProducts = await getAllFavouriteProducts(accessToken);

    notifyListeners();
  }

  ProductDetailsData? get productData => _productData;

  List<Product>? get productList => _productList;

  List<FavouriteProduct>? get favouriteProducts => _favouriteProducts;

  List<Product>? get productHotList => _productHotList;

  List<Product>? get discountHotProduct => _discountHotProductList;

  List<Product>? get newHotProduct => _newHotProductList;

  List<Product>? get statusHotProductList => _statusHotProductList;

  List<Product>? get searchProductList => _searchProductList;
}
