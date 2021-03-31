import 'package:eshop/data/service/services.dart';
import 'package:eshop/model/cart_data.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart with ChangeNotifier {
  List<CartData> _cartItems;
  // Map<String, CartItem> get items {
  //   return {...?_items};
  // }

  int get itemCount {
    return _cartItems.length;
  }

  double get totalMount {
    var total = 0.0;

    cartItems.forEach((item) {
      total += item.price * item.qty;
    });

    return total;
  }

  fetchCartList() async {
    final token = await _getToken();
    _cartItems = await fetchCartItems(token);
    notifyListeners();
  }

  Future<String> addItemToCart(int productId, int quantity) async {
    final token = await _getToken();
    String response = await addProductToCart(productId, quantity, token);
    return response;
  }

  List<CartData> get cartItems => _cartItems;

  Future _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token;
  }

  Future<void> clearCart() async {
    final token = await _getToken();
    await cleartUserCart(token);
  }

  removeItems(String productId) async {
    final token = await _getToken();
    await removeItemFromCart(int.parse(productId),token);
  }
}
