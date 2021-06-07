// To parse this JSON data, do
//
//     final orderData = orderDataFromJson(jsonString);

import 'dart:convert';

OrderData orderDataFromJson(String str) => OrderData.fromJson(json.decode(str));

String orderDataToJson(OrderData data) => json.encode(data.toJson());

class OrderData {
  OrderData({
    this.id,
    this.createdDate,
    this.customerName,
    this.phoneNumber,
    this.address,
    this.vat,
    this.subtotale,
    this.orderDate,
    this.orderdeitalsdto,
  });

  int? id;
  String? createdDate;
  String? customerName;
  String? phoneNumber;
  String? address;
  int? vat;
  int? subtotale;
  String? orderDate;
  List<Orderdeitalsdto>? orderdeitalsdto;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        createdDate: json["createdDate"],
        customerName: json["customerName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        vat: json["vat"],
        subtotale: json["subtotale"],
        orderDate: json["orderDate"],
        orderdeitalsdto: List<Orderdeitalsdto>.from(
            json["orderdeitalsdto"].map((x) => Orderdeitalsdto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "customerName": customerName,
        "phoneNumber": phoneNumber,
        "address": address,
        "vat": vat,
        "subtotale": subtotale,
        "orderDate": orderDate,
        "orderdeitalsdto":
            List<dynamic>.from(orderdeitalsdto!.map((x) => x.toJson())),
      };
}

class Orderdeitalsdto {
  Orderdeitalsdto({
    this.image,
    this.price,
    this.productId,
    this.productName,
    this.qty,
  });

  String? image;
  double? price;
  int? productId;
  String? productName;
  int? qty;

  factory Orderdeitalsdto.fromJson(Map<String, dynamic> json) =>
      Orderdeitalsdto(
        image: json["image"],
        price: json["price"],
        productId: json["productID"],
        productName: json["productName"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "price": price,
        "productID": productId,
        "productName": productName,
        "qty": qty,
      };
}
