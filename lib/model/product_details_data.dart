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
  dynamic order;
  String? createdDate;
  String? updatedDate;
  bool? isActive;
  bool? isDeleted;
  dynamic createdBy;
  dynamic updatedBy;
  String? nameAr;
  dynamic nameEn;
  String? imagePath;
  double? price;
  dynamic categoryId;
  int? supplierId;
  int? quantity;
  double? oldPrice;
  String? descriptionAr;
  dynamic descriptionEn;
  bool? isHot;
  dynamic newProduct;
  dynamic discountProduct;
  dynamic stutesProduct;
  Category? category;
  Supplier? supplier;
  List<dynamic>? carts;
  List<dynamic>? orderdeitals;
  List<ProductGallery>? productGalleries;
  List<AvilabeProductGallery>? avilabeProductGalleries;

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
        nameAr: json["nameAr"],
        nameEn: json["nameEn"],
        imagePath: json["imagePath"],
        price: json["price"],
        categoryId: json["categoryId"],
        supplierId: json["supplierId"],
        quantity: json["quantity"],
        oldPrice: json["oldPrice"],
        descriptionAr: json["descriptionAr"],
        descriptionEn: json["descriptionEn"],
        isHot: json["isHot"],
        newProduct: json["newProduct"],
        discountProduct: json["discountProduct"],
        stutesProduct: json["stutesProduct"],
        category: Category.fromJson(json["category"]),
        supplier: Supplier.fromJson(json["supplier"]),
        carts: List<dynamic>.from(json["carts"].map((x) => x)),
        orderdeitals: List<dynamic>.from(json["orderdeitals"].map((x) => x)),
        productGalleries: List<ProductGallery>.from(
            json["productGalleries"].map((x) => ProductGallery.fromJson(x))),
        avilabeProductGalleries: List<AvilabeProductGallery>.from(
            json["avilabeProductGalleries"]
                .map((x) => AvilabeProductGallery.fromJson(x))),
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
        "categoryId": categoryId,
        "supplierId": supplierId,
        "quantity": quantity,
        "oldPrice": oldPrice,
        "descriptionAr": descriptionAr,
        "descriptionEn": descriptionEn,
        "isHot": isHot,
        "newProduct": newProduct,
        "discountProduct": discountProduct,
        "stutesProduct": stutesProduct,
        "category": category!.toJson(),
        "supplier": supplier!.toJson(),
        "carts": List<dynamic>.from(carts!.map((x) => x)),
        "orderdeitals": List<dynamic>.from(orderdeitals!.map((x) => x)),
        "productGalleries":
            List<dynamic>.from(productGalleries!.map((x) => x.toJson())),
        "avilabeProductGalleries":
            List<dynamic>.from(avilabeProductGalleries!.map((x) => x.toJson())),
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

class AvilabeProductGallery {
  AvilabeProductGallery({
    this.id,
    this.textAr,
    this.textEn,
    this.productId,
    this.imagePath,
    this.product,
  });

  int? id;
  String? textAr;
  dynamic textEn;
  int? productId;
  String? imagePath;
  dynamic product;

  factory AvilabeProductGallery.fromJson(Map<String, dynamic> json) =>
      AvilabeProductGallery(
        id: json["id"],
        textAr: json["textAr"],
        textEn: json["textEn"],
        productId: json["productId"],
        imagePath: json["imagePath"],
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "textAr": textAr,
        "textEn": textEn,
        "productId": productId,
        "imagePath": imagePath,
        "product": product,
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
    this.nameAr,
    this.nameEn,
    this.parentCategoryId,
    this.mainCatgoryid,
    this.parentCategory,
    this.inverseParentCategory,
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
  dynamic nameAr;
  dynamic nameEn;
  dynamic parentCategoryId;
  dynamic mainCatgoryid;
  dynamic parentCategory;
  List<dynamic>? inverseParentCategory;
  List<dynamic>? products;
  List<dynamic>? suppliers;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
        parentCategoryId: json["parentCategoryId"],
        mainCatgoryid: json["mainCatgoryid"],
        parentCategory: json["parentCategory"],
        inverseParentCategory:
            List<dynamic>.from(json["inverseParentCategory"].map((x) => x)),
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
        "nameAr": nameAr,
        "nameEn": nameEn,
        "parentCategoryId": parentCategoryId,
        "mainCatgoryid": mainCatgoryid,
        "parentCategory": parentCategory,
        "inverseParentCategory":
            List<dynamic>.from(inverseParentCategory!.map((x) => x)),
        "products": List<dynamic>.from(products!.map((x) => x)),
        "suppliers": List<dynamic>.from(suppliers!.map((x) => x)),
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
    this.nameAr,
    this.nameEn,
    this.phoneNumber,
    this.cityId,
    this.imagePath,
    this.imagePath1,
    this.rate,
    this.govid,
    this.mainCategoryid,
    this.categoryId,
    this.openTime,
    this.closeTime,
    this.category,
    this.city,
    this.gov,
    this.mainCategory,
    this.products,
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
  dynamic? phoneNumber;
  dynamic? cityId;
  dynamic? imagePath;
  dynamic? imagePath1;
  dynamic? rate;
  int? govid;
  int? mainCategoryid;
  dynamic? categoryId;
  dynamic? openTime;
  dynamic? closeTime;
  dynamic? category;
  dynamic? city;
  dynamic? gov;
  dynamic? mainCategory;
  List<dynamic>? products;

  factory Supplier.fromJson(Map<String?, dynamic> json) => Supplier(
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
        phoneNumber: json["phoneNumber"],
        cityId: json["cityId"],
        imagePath: json["imagePath"],
        imagePath1: json["imagePath1"],
        rate: json["rate"],
        govid: json["govid"],
        mainCategoryid: json["mainCategoryid"],
        categoryId: json["categoryId"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        category: json["category"],
        city: json["city"],
        gov: json["gov"],
        mainCategory: json["mainCategory"],
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
        "nameAr": nameAr,
        "nameEn": nameEn,
        "phoneNumber": phoneNumber,
        "cityId": cityId,
        "imagePath": imagePath,
        "imagePath1": imagePath1,
        "rate": rate,
        "govid": govid,
        "mainCategoryid": mainCategoryid,
        "categoryId": categoryId,
        "openTime": openTime,
        "closeTime": closeTime,
        "category": category,
        "city": city,
        "gov": gov,
        "mainCategory": mainCategory,
        "products": List<dynamic>.from(products!.map((x) => x)),
      };
}
