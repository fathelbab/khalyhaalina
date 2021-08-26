import 'package:eshop/data/service/cart_service.dart';
import 'package:eshop/model/cart_data.dart';
import 'package:eshop/utils/cache_helper.dart';
import 'package:eshop/utils/log.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart with ChangeNotifier {
  List<CartData>? _cartItems;
  // Map<String, CartItem> get items {
  //   return {...?_items};
  // }

  int get itemCount {
    return _cartItems!.length;
  }

  double get totalMount {
    var total = 0.0;

    cartItems!.forEach((item) {
      total += item.price! * item.qty!;
    });

    return total;
  }

  fetchCartList() async {
    final token = CacheHelper.getPrefs(key: "token");
    _cartItems = await fetchCartItems(token);
    notifyListeners();
  }

  Future<String> addItemToCart(
      int? productId, int quantity, String? description) async {
    final token = CacheHelper.getPrefs(key: "token");
    String response =
        await addProductToCart(productId, quantity, description ?? "", token);
    return response;
  }

  List<CartData>? get cartItems => _cartItems;

  // Future _getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   return token;
  // }

  Future<void> clearCart() async {
    final token = CacheHelper.getPrefs(key: "token");
    await cleartUserCart(token);
  }

  increaseQuantity(
    int productId,
  ) {
    _cartItems?.map((product) {
      if (product.id == productId && product.qty != null) {
        product.qty = product.qty! + 1;
      }
    }).toList();
    notifyListeners();
  }

  decreaseQuantity(
    int productId,
  ) {
    _cartItems?.map((product) {
      if (product.id == productId && product.qty! > 1) {
        product.qty = product.qty! - 1;
        Log.d(product.qty.toString());
      }
    }).toList();
    notifyListeners();
  }

  removeItems(String productId) async {
    final token = CacheHelper.getPrefs(key: "token");
    await removeItemFromCart(int.parse(productId), token);
    _cartItems!.removeWhere((element) => element.id == int.parse(productId));
    notifyListeners();
  }
}
