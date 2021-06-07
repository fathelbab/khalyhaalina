// To parse this JSON data, do
//
//     final announcementData = announcementDataFromJson(jsonString);

import 'dart:convert';

List<AnnouncementData> announcementDataFromJson(String str) => List<AnnouncementData>.from(json.decode(str).map((x) => AnnouncementData.fromJson(x)));

String announcementDataToJson(List<AnnouncementData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnnouncementData {
    AnnouncementData({
        this.id,
        this.order,
        this.createdDate,
        this.updatedDate,
        this.isActive,
        this.isDeleted,
        this.createdBy,
        this.updatedBy,
        this.title,
        this.imagePath,
    });

    int? id;
    dynamic order;
    String? createdDate;
    String? updatedDate;
    bool? isActive;
    bool? isDeleted;
    dynamic createdBy;
    dynamic updatedBy;
    String? title;
    String? imagePath;

    factory AnnouncementData.fromJson(Map<String, dynamic> json) => AnnouncementData(
        id: json["id"],
        order: json["order"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        title: json["title"] == null ? null : json["title"],
        imagePath: json["imagePath"],
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
        "title": title == null ? null : title,
        "imagePath": imagePath,
    };
}
