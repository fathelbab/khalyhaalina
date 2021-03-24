// To parse this JSON data, do
//
//     final cartData = cartDataFromJson(jsonString);

import 'dart:convert';

List<CartData> cartDataFromJson(String str) => List<CartData>.from(json.decode(str).map((x) => CartData.fromJson(x)));

String cartDataToJson(List<CartData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartData {
    CartData({
        this.id,
        this.qty,
        this.price,
        this.totaleamount,
        this.image,
        this.name,
    });

    int id;
    int qty;
    double price;
    double totaleamount;
    String image;
    String name;

    factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        id: json["id"],
        qty: json["qty"],
        price: json["price"],
        totaleamount: json["totaleamount"],
        image: json["image"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "qty": qty,
        "price": price,
        "totaleamount": totaleamount,
        "image": image,
        "name": name,
    };
}
