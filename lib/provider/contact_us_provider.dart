import 'package:flutter/material.dart';
import 'package:eshop/data/service/services.dart';

class CallUsProvider with ChangeNotifier {
  Future<String> sendUserCompliatOrSuggestion(String firstName, String lastName,
      String email, String phoneNumber, String userMessage) async {
    String response = await sendCompliatOrSuggestion(
        firstName, lastName, email, phoneNumber, userMessage);
    return response;
  }
}
