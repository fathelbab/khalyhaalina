// To parse this JSON data, do
//
//     final productData = productDataFromJson(jsonString);

import 'dart:convert';

ProductData productDataFromJson(String str) =>
    ProductData.fromJson(json.decode(str));

String productDataToJson(ProductData data) => json.encode(data.toJson());

class ProductData {
  int offset;
  int limit;
  int length;
  List<Product> product;

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
        product:List<Product>.from(json["result"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "length": length,
        "result": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.imagePath,
    this.price,
    this.categoryName,
    this.supplierName,
    this.categoryId,
    this.supplierId,
    this.imageExtension,
    this.imageBase64,
    this.order,
  });

  int id;
  String name;
  String imagePath;
  double price;
  String categoryName;
  String supplierName;
  int categoryId;
  int supplierId;
  dynamic imageExtension;
  dynamic imageBase64;
  int order;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        imagePath: json["imagePath"],
        price: json["price"],
        categoryName: json["categoryName"],
        supplierName:
            json["supplierName"] == null ? null : json["supplierName"],
        categoryId: json["categoryId"],
        supplierId: json["supplierId"],
        imageExtension: json["imageExtension"],
        imageBase64: json["imageBase64"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imagePath": imagePath,
        "price": price,
        "categoryName": categoryName,
        "supplierName": supplierName == null ? null : supplierName,
        "categoryId": categoryId,
        "supplierId": supplierId,
        "imageExtension": imageExtension,
        "imageBase64": imageBase64,
        "order": order,
      };
}
