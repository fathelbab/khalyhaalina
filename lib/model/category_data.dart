// To parse this JSON data, do
//
//     final categoryData = categoryDataFromJson(jsonString);

import 'dart:convert';

CategoryData categoryDataFromJson(String str) => CategoryData.fromJson(json.decode(str));

String categoryDataToJson(CategoryData data) => json.encode(data.toJson());

class CategoryData {
  CategoryData({
    this.offset,
    this.limit,
    this.length,
    this.result,
  });

  int offset;
  int limit;
  int length;
  List<Category> result;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    offset: json["offset"],
    limit: json["limit"],
    length: json["length"],
    result: List<Category>.from(json["result"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "offset": offset,
    "limit": limit,
    "length": length,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.order,
  });

  int id;
  String name;
  int order;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "order": order,
  };
}
