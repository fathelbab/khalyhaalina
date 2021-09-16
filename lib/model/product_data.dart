// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

ProductData productDataFromJson(String str) =>
    ProductData.fromJson(json.decode(str));

String productToJson(ProductData data) => json.encode(data.toJson());

class ProductData {
  ProductData({
    this.offset,
    this.product,
    this.limit,
    this.length,
  });

  int? offset;
  List<Product>? product;
  int? limit;
  int? length;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        offset: json["offset"],
        product:
            List<Product>.from(json["result"].map((x) => Product.fromJson(x))),
        limit: json["limit"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "result": List<dynamic>.from(product!.map((x) => x.toJson())),
        "limit": limit,
        "length": length,
      };
}

class Product {
  Product({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.newProduct,
    this.discountProduct,
    this.stutesProduct,
    this.order,
    this.imagePath,
    this.price,
    this.oldPrice,
    this.quantity,
    this.categoryId,
    this.supplierId,
    this.isHot,
    this.isFavority,
  });

  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  dynamic newProduct;
  dynamic discountProduct;
  dynamic stutesProduct;
  dynamic order;
  String? imagePath;
  double? price;
  double? oldPrice;
  int? quantity;
  int? categoryId;
  int? supplierId;
  bool? isHot;
  bool? isFavority;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"] == null ? null : json["nameEn"],
        descriptionAr: json["descriptionAr"],
        descriptionEn: json["descriptionEn"],
        newProduct: json["newProduct"],
        discountProduct: json["discountProduct"],
        stutesProduct: json["stutesProduct"],
        order: json["order"],
        imagePath: json["imagePath"],
        price: json["price"].toDouble(),
        oldPrice: json["oldPrice"],
        quantity: json["quantity"],
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
        supplierId: json["supplierId"],
        isHot: json["isHot"],
        isFavority: json["isFavority"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn == null ? null : nameEn,
        "descriptionAr": descriptionAr,
        "descriptionEn": descriptionEn,
        "newProduct": newProduct,
        "discountProduct": discountProduct,
        "stutesProduct": stutesProduct,
        "order": order,
        "imagePath": imagePath,
        "price": price,
        "oldPrice": oldPrice,
        "quantity": quantity,
        "categoryId": categoryId == null ? null : categoryId,
        "supplierId": supplierId,
        "isHot": isHot,
        "isFavority": isFavority,
      };
}
