import 'package:eshop/data/service/contact_us_service.dart';
import 'package:eshop/data/service/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:eshop/data/service/services.dart';

class ContactUsProvider with ChangeNotifier {
  Future<String> sendUserComplainsOrSuggestion(String firstName, String lastName,
      String email, String phoneNumber, String userMessage) async {
    String response = await sendComplainsOrSuggestionService(
        firstName, lastName, email, phoneNumber, userMessage);
    return response;
  }

  Future<String> sendOnlineSupport(String firstName, String lastName,
      String address, String phoneNumber, String comment) async {
    String response = await sendOnlineSupportService(
        firstName, lastName, phoneNumber, address, comment);
    return response;
  }
}
