// To parse this JSON data, do
//
//     final gifModels = gifModelsFromJson(jsonString);

import 'dart:convert';

List<GifModels> gifModelsFromJson(String str) =>
    List<GifModels>.from(json.decode(str).map((x) => GifModels.fromJson(x)));

String gifModelsToJson(List<GifModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GifModels {
  GifModels({
    this.imagePath,
    this.cityId,
    this.hasSupplier,
    this.supplierId,
  });

  String? imagePath;
  int? cityId;
  bool? hasSupplier;
  int? supplierId;

  factory GifModels.fromJson(Map<String, dynamic> json) => GifModels(
        imagePath: json["imagePath"],
        cityId: json["cityId"],
        hasSupplier: json["hasSupplier"],
        supplierId: json["supplierId"] == null ? null : json["supplierId"],
      );

  Map<String, dynamic> toJson() => {
        "imagePath": imagePath,
        "cityId": cityId,
        "hasSupplier": hasSupplier,
        "supplierId": supplierId == null ? null : supplierId,
      };
}
