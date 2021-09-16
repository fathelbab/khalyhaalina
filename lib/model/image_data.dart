// To parse this JSON data, do
//
//     final imageData = imageDataFromJson(jsonString);

import 'dart:convert';

List<ImageData> imageDataFromJson(String str) =>
    List<ImageData>.from(json.decode(str).map((x) => ImageData.fromJson(x)));

String imageDataToJson(List<ImageData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageData {
  ImageData({
    this.imagePath,
    this.title,
    this.cityId,
    this.hasProduct,
    this.productId,
  });

  String? title;
  String? imagePath;

  int? cityId;
  bool? hasProduct;
  int? productId;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        cityId: json["cityId"],
        hasProduct: json["hasProduct"],
        productId: json["productId"],
        title: json["title"] == null ? null : json["title"],
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toJson() => {
        "imagePath": imagePath,
        "title": title,
        "cityId": cityId,
        "hasProduct": hasProduct,
        "productId": productId,
      };
}
