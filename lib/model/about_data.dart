// To parse this JSON data, do
//
//     final aboutData = aboutDataFromJson(jsonString);

import 'dart:convert';

List<AboutData> aboutDataFromJson(String str) =>
    List<AboutData>.from(json.decode(str).map((x) => AboutData.fromJson(x)));

String aboutDataToJson(List<AboutData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AboutData {
  AboutData({
    this.id,
    this.order,
    this.createdDate,
    this.updatedDate,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.content,
  });

  int? id;
  dynamic order;
  String? createdDate;
  String? updatedDate;
  bool? isActive;
  bool? isDeleted;
  dynamic createdBy;
  dynamic updatedBy;
  String? content;

  factory AboutData.fromJson(Map<String, dynamic> json) => AboutData(
        id: json["id"],
        order: json["order"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        content: json["content"],
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
        "content": content,
      };
}
