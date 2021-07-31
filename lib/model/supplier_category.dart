// To parse this JSON data, do
//
//     final supplierCategory = supplierCategoryFromJson(jsonString);

import 'dart:convert';

SupplierCategory supplierCategoryFromJson(String str) =>
    SupplierCategory.fromJson(json.decode(str));

String supplierCategoryToJson(SupplierCategory data) =>
    json.encode(data.toJson());

class SupplierCategory {
  SupplierCategory({
    this.offset,
    this.result,
    this.limit,
    this.length,
  });

  int? offset;
  List<Result>? result;
  int? limit;
  int? length;

  factory SupplierCategory.fromJson(Map<String, dynamic> json) =>
      SupplierCategory(
        offset: json["offset"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        limit: json["limit"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "limit": limit,
        "length": length,
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.order,
    this.createdDate,
    this.childs,
  });

  int? id;
  String? name;
  dynamic order;
  DateTime? createdDate;
  List<Result>? childs;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        order: json["order"],
        createdDate: DateTime.parse(json["createdDate"]),
        childs: json["childs"] == null
            ? null
            : List<Result>.from(json["childs"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "order": order,
        "createdDate": createdDate!.toIso8601String(),
        "childs": childs == null
            ? null
            : List<dynamic>.from(childs!.map((x) => x.toJson())),
      };
}
