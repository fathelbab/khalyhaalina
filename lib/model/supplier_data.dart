// To parse this JSON data, do
//
//     final supplierData = supplierDataFromJson(jsonString);

import 'dart:convert';

SupplierData supplierDataFromJson(String str) => SupplierData.fromJson(json.decode(str));

String supplierDataToJson(SupplierData data) => json.encode(data.toJson());

class SupplierData {
    SupplierData({
        this.offset,
        this.limit,
        this.length,
        this.supplier,
    });

    int offset;
    int limit;
    int length;
    List<Supplier> supplier;

    factory SupplierData.fromJson(Map<String, dynamic> json) => SupplierData(
        offset: json["offset"],
        limit: json["limit"],
        length: json["length"],
        supplier: List<Supplier>.from(json["result"].map((x) => Supplier.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "length": length,
        "result": List<dynamic>.from(supplier.map((x) => x.toJson())),
    };
}

class Supplier {
    Supplier({
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
    int price;
    String categoryName;
    String supplierName;
    int categoryId;
    int supplierId;
    dynamic imageExtension;
    dynamic imageBase64;
    int order;

    factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        name: json["name"],
        imagePath: json["imagePath"],
        price: json["price"],
        categoryName: json["categoryName"],
        supplierName: json["supplierName"] == null ? null : json["supplierName"],
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
