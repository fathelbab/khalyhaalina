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
    this.id,
    this.gifUrl,
    this.cityId,
  });

  int? id;
  String? gifUrl;
  int? cityId;

  factory GifModels.fromJson(Map<String, dynamic> json) => GifModels(
        id: json["id"],
        gifUrl: json["gifUrl"],
        cityId: json["cityId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gifUrl": gifUrl,
        "cityId": cityId,
      };
}
