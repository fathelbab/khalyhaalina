// To parse this JSON data, do
//
//     final cityData = cityDataFromJson(jsonString);

import 'dart:convert';

CityData cityDataFromJson(String str) => CityData.fromJson(json.decode(str));

String cityDataToJson(CityData data) => json.encode(data.toJson());

class CityData {
    CityData({
        this.offset,
        this.limit,
        this.length,
        this.city,
    });

    int offset;
    int limit;
    int length;
    List<City> city;

    factory CityData.fromJson(Map<String, dynamic> json) => CityData(
        offset: json["offset"],
        limit: json["limit"],
        length: json["length"],
        city: List<City>.from(json["result"].map((x) => City.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "length": length,
        "result": List<dynamic>.from(city.map((x) => x.toJson())),
    };
}

class City {
    City({
        this.name,
        this.id,
        this.order,
        this.isActive,
    });

    String name;
    int id;
    dynamic order;
    bool isActive;

    factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["name"],
        id: json["id"],
        order: json["order"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "order": order,
        "isActive": isActive,
    };
}
