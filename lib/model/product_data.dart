// To parse this JSON data, do
//
//     final productData = productDataFromJson(jsonString);

import 'dart:convert';

ProductData productDataFromJson(String str) =>
    ProductData.fromJson(json.decode(str));

String productDataToJson(ProductData data) => json.encode(data.toJson());

class ProductData {
  int? offset;
  int? limit;
  int? length;
  List<Product>? product;

  ProductData({
    this.offset,
    this.limit,
    this.length,
    this.product,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        offset: json["offset"],
        limit: json["limit"],
        length: json["length"],
        product:
            List<Product>.from(json["result"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "length": length,
        "result": List<dynamic>.from(product!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.order,
    this.imagePath,
    this.price,
    this.oldPrice,
    this.categoryName,
    this.supplierName,
    this.quantity,
    this.categoryId,
    this.supplierId,
    this.isHot,
  });

  int? id;
  String? name;
  dynamic order;
  String? imagePath;
  double? price;
  double? oldPrice;
  String? categoryName;
  String? supplierName;
  int? quantity;
  int? categoryId;
  int? supplierId;
  bool? isHot;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        order: json["order"],
        imagePath: json["imagePath"],
        price: json["price"],
        oldPrice: json["oldPrice"],
        categoryName: json["categoryName"],
        supplierName: json["supplierName"],
        quantity: json["quantity"],
        categoryId: json["categoryId"],
        supplierId: json["supplierId"],
        isHot: json["isHot"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "order": order,
        "imagePath": imagePath,
        "price": price,
        "oldPrice": oldPrice,
        "categoryName": categoryName,
        "supplierName": supplierName,
        "quantity": quantity,
        "categoryId": categoryId,
        "supplierId": supplierId,
        "isHot": isHot,
      };
}
