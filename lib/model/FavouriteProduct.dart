// To parse this JSON data, do
//
//     final favouriteProduct = favouriteProductFromJson(jsonString);

import 'dart:convert';

List<FavouriteProduct> favouriteProductFromJson(String str) =>
    List<FavouriteProduct>.from(
        json.decode(str).map((x) => FavouriteProduct.fromJson(x)));

String favouriteProductToJson(List<FavouriteProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavouriteProduct {
  FavouriteProduct({
    this.id,
    this.order,
    this.createdDate,
    this.updatedDate,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.nameAr,
    this.nameEn,
    this.imagePath,
    this.price,
    this.categoryId,
    this.supplierId,
    this.quantity,
    this.oldPrice,
    this.descriptionAr,
    this.descriptionEn,
    this.isHot,
    this.newProduct,
    this.discountProduct,
    this.stutesProduct,
    this.category,
    this.supplier,
    this.carts,
    this.orderdeitals,
    this.productGalleries,
    this.avilabeProductGalleries,
  });

  int? id;
  dynamic? order;
  String? createdDate;
  String? updatedDate;
  bool? isActive;
  bool? isDeleted;
  dynamic? createdBy;
  dynamic? updatedBy;
  String? nameAr;
  String? nameEn;
  String? imagePath;
  double? price;
  int? categoryId;
  int? supplierId;
  int? quantity;
  double? oldPrice;
  String? descriptionAr;
  String? descriptionEn;
  bool? isHot;
  String? newProduct;
  String? discountProduct;
  String? stutesProduct;
  dynamic? category;
  dynamic? supplier;
  List<dynamic>? carts;
  List<dynamic>? orderdeitals;
  List<dynamic>? productGalleries;
  dynamic? avilabeProductGalleries;

  factory FavouriteProduct.fromJson(Map<String, dynamic> json) =>
      FavouriteProduct(
        id: json["id"],
        order: json["order"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"] == null ? null : json["nameEn"],
        imagePath: json["imagePath"],
        price: json["price"],
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
        supplierId: json["supplierId"],
        quantity: json["quantity"],
        oldPrice: json["oldPrice"],
        descriptionAr: json["descriptionAr"],
        descriptionEn: json["descriptionEn"],
        isHot: json["isHot"],
        newProduct: json["newProduct"] == null ? null : json["newProduct"],
        discountProduct:
            json["discountProduct"] == null ? null : json["discountProduct"],
        stutesProduct:
            json["stutesProduct"] == null ? null : json["stutesProduct"],
        category: json["category"],
        supplier: json["supplier"],
        carts: List<dynamic>.from(json["carts"].map((x) => x)),
        orderdeitals: List<dynamic>.from(json["orderdeitals"].map((x) => x)),
        productGalleries:
            List<dynamic>.from(json["productGalleries"].map((x) => x)),
        avilabeProductGalleries: json["avilabeProductGalleries"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order": order,
        "createdDate": createdDate,
        "updatedDate": updatedDate,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "nameAr": nameAr,
        "nameEn": nameEn == null ? null : nameEn,
        "imagePath": imagePath,
        "price": price,
        "categoryId": categoryId == null ? null : categoryId,
        "supplierId": supplierId,
        "quantity": quantity,
        "oldPrice": oldPrice,
        "descriptionAr": descriptionAr,
        "descriptionEn": descriptionEn,
        "isHot": isHot,
        "newProduct": newProduct == null ? null : newProduct,
        "discountProduct": discountProduct == null ? null : discountProduct,
        "stutesProduct": stutesProduct == null ? null : stutesProduct,
        "category": category,
        "supplier": supplier,
        "carts": List<dynamic>.from(carts!.map((x) => x)),
        "orderdeitals": List<dynamic>.from(orderdeitals!.map((x) => x)),
        "productGalleries": List<dynamic>.from(productGalleries!.map((x) => x)),
        "avilabeProductGalleries": avilabeProductGalleries,
      };
}
