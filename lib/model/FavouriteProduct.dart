// To parse this JSON data, do
//
//     final favouriteFavouriteProductData = favouriteFavouriteProductDataFromJson(jsonString);

import 'dart:convert';

List<FavouriteProduct> favouriteFavouriteProductDataFromJson(String str) =>
    List<FavouriteProduct>.from(
        json.decode(str).map((x) => FavouriteProduct.fromJson(x)));

String favouriteFavouriteProductDataToJson(List<FavouriteProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavouriteProduct {
  FavouriteProduct({
    this.id,
    this.productId,
    this.product,
    this.userId,
    this.user,
  });

  int? id;
  int? productId;
  FavouriteProductData? product;
  String? userId;
  dynamic user;

  factory FavouriteProduct.fromJson(Map<String, dynamic> json) =>
      FavouriteProduct(
        id: json["id"],
        productId: json["productId"],
        product: FavouriteProductData.fromJson(json["product"]),
        userId: json["userId"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "product": product!.toJson(),
        "userId": userId,
        "user": user,
      };
}

class FavouriteProductData {
  FavouriteProductData({
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
    this.newFavouriteProductData,
    this.discountFavouriteProductData,
    this.stutesFavouriteProductData,
    this.category,
    this.supplier,
    this.carts,
    this.orderdeitals,
    this.productGalleries,
    this.avilabeFavouriteProductDataGalleries,
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
  dynamic? nameEn;
  String? imagePath;
  double? price;
  int? categoryId;
  int? supplierId;
  int? quantity;
  double? oldPrice;
  String? descriptionAr;
  String? descriptionEn;
  bool? isHot;
  dynamic? newFavouriteProductData;
  dynamic? discountFavouriteProductData;
  dynamic? stutesFavouriteProductData;
  dynamic? category;
  dynamic? supplier;
  List<dynamic>? carts;
  List<dynamic>? orderdeitals;
  List<dynamic>? productGalleries;
  dynamic? avilabeFavouriteProductDataGalleries;

  factory FavouriteProductData.fromJson(Map<String, dynamic> json) => FavouriteProductData(
        id: json["id"],
        order: json["order"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        imagePath: json["imagePath"],
        price: json["price"],
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
        supplierId: json["supplierId"],
        quantity: json["quantity"],
        oldPrice: json["oldPrice"],
        descriptionAr: json["descriptionAr"],
        descriptionEn: json["descriptionEn"],
        isHot: json["isHot"],
        newFavouriteProductData: json["newFavouriteProductData"],
        discountFavouriteProductData: json["discountFavouriteProductData"],
        stutesFavouriteProductData: json["stutesFavouriteProductData"],
        category: json["category"],
        supplier: json["supplier"],
        carts: List<dynamic>.from(json["carts"].map((x) => x)),
        orderdeitals: List<dynamic>.from(json["orderdeitals"].map((x) => x)),
        productGalleries:
            List<dynamic>.from(json["productGalleries"].map((x) => x)),
        avilabeFavouriteProductDataGalleries: json["avilabeFavouriteProductDataGalleries"],
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
        "nameEn": nameEn,
        "imagePath": imagePath,
        "price": price,
        "categoryId": categoryId == null ? null : categoryId,
        "supplierId": supplierId,
        "quantity": quantity,
        "oldPrice": oldPrice,
        "descriptionAr": descriptionAr,
        "descriptionEn": descriptionEn,
        "isHot": isHot,
        "newFavouriteProductData": newFavouriteProductData,
        "discountFavouriteProductData": discountFavouriteProductData,
        "stutesFavouriteProductData": stutesFavouriteProductData,
        "category": category,
        "supplier": supplier,
        "carts": List<dynamic>.from(carts!.map((x) => x)),
        "orderdeitals": List<dynamic>.from(orderdeitals!.map((x) => x)),
        "productGalleries": List<dynamic>.from(productGalleries!.map((x) => x)),
        "avilabeFavouriteProductDataGalleries": avilabeFavouriteProductDataGalleries,
      };
}
