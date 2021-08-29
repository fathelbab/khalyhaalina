import 'package:eshop/model/cart_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eshop/data/service/services.dart';

class OrderProvider with ChangeNotifier {
  Future<String> createOrder(
    String customerName,
    String phoneNumber,
    String address,
    String receivedDate,
    double subTotal,
    List<CartData> listOfProduct,
  ) async {
    final token = await _getToken();
    String response = await createOrderbyUser(customerName, phoneNumber,
        address, receivedDate, subTotal, listOfProduct, token);
    return response;
  }

  Future _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token;
  }
}
