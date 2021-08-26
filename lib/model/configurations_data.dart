// To parse this JSON data, do
//
//     final configrationsData = configrationsDataFromJson(jsonString);

import 'dart:convert';

List<ConfigurationsData> configrationsDataFromJson(String str) =>
    List<ConfigurationsData>.from(
        json.decode(str).map((x) => ConfigurationsData.fromJson(x)));

String configrationsDataToJson(List<ConfigurationsData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConfigurationsData {
  ConfigurationsData({
    this.id,
    this.linkTikTok,
    this.linkYouTube,
    this.linkFaceBook,
    this.linkInstagram,
    this.linkWebSite,
    this.phoneNumber1,
    this.phoneNumber2,
    this.logo,
    this.gif,
    this.isDiscount,
    this.minLimt,
    this.discount,
  });

  int? id;
  String? linkTikTok;
  String? linkYouTube;
  String? linkFaceBook;
  String? linkInstagram;
  String? linkWebSite;
  String? phoneNumber1;
  String? phoneNumber2;
  String? logo;
  String? gif;
  bool? isDiscount;
  int? minLimt;
  int? discount;

  factory ConfigurationsData.fromJson(Map<String, dynamic> json) =>
      ConfigurationsData(
        id: json["id"],
        linkTikTok: json["linkTikTok"],
        linkYouTube: json["linkYouTube"],
        linkFaceBook: json["linkFaceBook"],
        linkInstagram: json["linkInstagram"],
        linkWebSite: json["linkWebSite"],
        phoneNumber1: json["phoneNumber1"],
        phoneNumber2: json["phoneNumber2"],
        logo: json["logo"],
        gif: json["gif"],
        isDiscount: json["isDiscount"],
        minLimt: json["minLimt"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "linkTikTok": linkTikTok,
        "linkYouTube": linkYouTube,
        "linkFaceBook": linkFaceBook,
        "linkInstagram": linkInstagram,
        "linkWebSite": linkWebSite,
        "phoneNumber1": phoneNumber1,
        "phoneNumber2": phoneNumber2,
        "logo": logo,
        "gif": gif,
        "isDiscount": isDiscount,
        "minLimt": minLimt,
        "discount": discount,
      };
}
