// To parse this JSON data, do
//
//     final mainCategory = mainCategoryFromJson(jsonString);

import 'dart:convert';

List<MainCategory> mainCategoryFromJson(String str) => List<MainCategory>.from(
    json.decode(str).map((x) => MainCategory.fromJson(x)));

String mainCategoryToJson(List<MainCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainCategory {
  MainCategory({
    this.id,
    this.nameAr,
    this.nameEn,
    this.parentid,
    this.image1,
    this.image2,
    this.subCategory,
  });

  int? id;
  String? nameAr;
  String? nameEn;
  int? parentid;
  String? image1;
  String? image2;
  List<SubCategory>? subCategory;

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
        id: json["id"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"] == null ? null : json["nameEn"],
        parentid: json["parentid"] == null ? null : json["parentid"],
        image1: json["image1"],
        image2: json["image2"],
        subCategory: List<SubCategory>.from(
            json["childs"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn == null ? null : nameEn,
        "parentid": parentid == null ? null : parentid,
        "image1": image1,
        "image2": image2,
        "childs": List<dynamic>.from(subCategory!.map((x) => x.toJson())),
      };
}

class SubCategory {
  SubCategory({
    this.id,
    this.nameAr,
    this.nameEn,
    this.parentid,
    this.image1,
    this.image2,
    this.childs,
  });

  int? id;
  String? nameAr;
  String? nameEn;
  int? parentid;
  String? image1;
  String? image2;
  List<SubCategory>? childs;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        nameAr: json["nameAr"],
        nameEn: json["nameEn"] == null ? null : json["nameEn"],
        parentid: json["parentid"] == null ? null : json["parentid"],
        image1: json["image1"],
        image2: json["image2"],
        childs: List<SubCategory>.from(
            json["childs"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameAr": nameAr,
        "nameEn": nameEn == null ? null : nameEn,
        "parentid": parentid == null ? null : parentid,
        "image1": image1,
        "image2": image2,
        "childs": List<dynamic>.from(childs!.map((x) => x.toJson())),
      };
}
