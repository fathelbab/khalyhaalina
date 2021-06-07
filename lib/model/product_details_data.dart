// To parse this JSON data, do
//
//     final productDetailsData = productDetailsDataFromJson(jsonString);

import 'dart:convert';

ProductDetailsData productDetailsDataFromJson(String str) =>
    ProductDetailsData.fromJson(json.decode(str));

String productDetailsDataToJson(ProductDetailsData data) =>
    json.encode(data.toJson());

class ProductDetailsData {
  ProductDetailsData({
    this.id,
    this.order,
    this.createdDate,
    this.updatedDate,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.name,
    this.imagePath,
    this.price,
    this.categoryId,
    this.supplierId,
    this.quantity,
    this.oldPrice,
    this.description,
    this.isHot,
    this.category,
    this.supplier,
    this.carts,
    this.productGalleries,
    this.orderdeitals,
  });

  int? id;
  dynamic order;
  String? createdDate;
  String? updatedDate;
  bool? isActive;
  bool? isDeleted;
  dynamic createdBy;
  dynamic updatedBy;
  String? name;
  String? imagePath;
  double? price;
  int? categoryId;
  int? supplierId;
  int? quantity;
  double? oldPrice;
  String? description;
  bool? isHot;
  Category? category;
  Supplier? supplier;
  List<dynamic>? carts = [];
  List<ProductGallery>? productGalleries = [];
  dynamic orderdeitals;

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) =>
      ProductDetailsData(
        id: json["id"],
        order: json["order"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        name: json["name"],
        imagePath: json["imagePath"],
        price: json["price"],
        categoryId: json["categoryId"],
        supplierId: json["supplierId"],
        quantity: json["quantity"],
        oldPrice: json["oldPrice"],
        description: json["description"],
        isHot: json["isHot"],
        category: Category.fromJson(json["category"]),
        supplier: Supplier.fromJson(json["supplier"]),
        carts: json["carts"] == null
            ? []
            : List<dynamic>.from(json["carts"].map((x) => x)),
        productGalleries: List<ProductGallery>.from(
            json["productGalleries"].map((x) => ProductGallery.fromJson(x))),
        orderdeitals: json["orderdeitals"],
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
        "name": name,
        "imagePath": imagePath,
        "price": price,
        "categoryId": categoryId,
        "supplierId": supplierId,
        "quantity": quantity,
        "oldPrice": oldPrice,
        "description": description,
        "isHot": isHot,
        "category": category!.toJson(),
        "supplier": supplier!.toJson(),
        "carts": List<dynamic>.from(carts!.map((x) => x)),
        "productGalleries":
            List<dynamic>.from(productGalleries!.map((x) => x.toJson())),
        "orderdeitals": orderdeitals,
      };
}

class Category {
  Category({
    this.id,
    this.order,
    this.createdDate,
    this.updatedDate,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.name,
    this.products,
    this.suppliers,
  });

  int? id;
  dynamic order;
  String? createdDate;
  String? updatedDate;
  bool? isActive;
  bool? isDeleted;
  dynamic createdBy;
  dynamic updatedBy;
  String? name;
  List<dynamic>? products = [];
  List<dynamic>? suppliers = [];

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        order: json["order"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        name: json["name"],
        products: List<dynamic>.from(json["products"].map((x) => x)),
        suppliers: List<dynamic>.from(json["suppliers"].map((x) => x)),
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
        "name": name,
        "products": List<dynamic>.from(products!.map((x) => x)),
        "suppliers": List<dynamic>.from(suppliers!.map((x) => x)),
      };
}

class ProductGallery {
  ProductGallery({
    this.id,
    this.productId,
    this.imagePath,
    this.product,
  });

  int? id;
  int? productId;
  String? imagePath;
  dynamic product;

  factory ProductGallery.fromJson(Map<String, dynamic> json) => ProductGallery(
        id: json["id"],
        productId: json["productId"],
        imagePath: json["imagePath"],
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "imagePath": imagePath,
        "product": product,
      };
}

class Supplier {
  Supplier({
    this.id,
    this.order,
    this.createdDate,
    this.updatedDate,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.name,
    this.phoneNumber,
    this.cityId,
    this.imagePath,
    this.rate,
    this.categoryId,
    this.category,
    this.city,
    this.products,
  });

  int? id;
  dynamic order;
  String? createdDate;
  String? updatedDate;
  bool? isActive;
  bool? isDeleted;
  dynamic createdBy;
  dynamic updatedBy;
  String? name;
  dynamic phoneNumber;
  dynamic cityId;
  dynamic imagePath;
  dynamic rate;
  dynamic categoryId;
  dynamic category;
  dynamic city;
  List<dynamic>? products = [];

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        order: json["order"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        cityId: json["cityId"],
        imagePath: json["imagePath"],
        rate: json["rate"],
        categoryId: json["categoryId"],
        category: json["category"],
        city: json["city"],
        products: List<dynamic>.from(json["products"].map((x) => x)),
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
        "name": name,
        "phoneNumber": phoneNumber,
        "cityId": cityId,
        "imagePath": imagePath,
        "rate": rate,
        "categoryId": categoryId,
        "category": category,
        "city": city,
        "products": List<dynamic>.from(products!.map((x) => x)),
      };
}
