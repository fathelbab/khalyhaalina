// To parse this JSON data, do
//
//     final notificationsData = notificationsDataFromJson(jsonString);

import 'dart:convert';

NotificationsData notificationsDataFromJson(String str) =>
    NotificationsData.fromJson(json.decode(str));

String notificationsDataToJson(NotificationsData data) =>
    json.encode(data.toJson());

class NotificationsData {
  NotificationsData({
    this.offset,
    this.notification,
    this.limit,
    this.length,
  });

  int? offset;
  List<Notifications>? notification;
  int? limit;
  int? length;

  factory NotificationsData.fromJson(Map<String, dynamic> json) =>
      NotificationsData(
        offset: json["offset"],
        notification: List<Notifications>.from(
            json["result"].map((x) => Notifications.fromJson(x))),
        limit: json["limit"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "result": List<dynamic>.from(notification!.map((x) => x.toJson())),
        "limit": limit,
        "length": length,
      };
}

class Notifications {
  Notifications({
    this.id,
    this.order,
    this.createdDate,
    this.updatedDate,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.updatedBy,
    this.text,
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
  String? text;
  String? imagePath;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        order: json["order"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        text: json["text"],
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
        "text": text,
        "imagePath": imagePath,
      };
}
