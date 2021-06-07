// To parse this JSON data, do
//
//     final doctorDetailsData = doctorDetailsDataFromJson(jsonString);

import 'dart:convert';

DoctorDetailsData doctorDetailsDataFromJson(String str) => DoctorDetailsData.fromJson(json.decode(str));

String doctorDetailsDataToJson(DoctorDetailsData data) => json.encode(data.toJson());

class DoctorDetailsData {
    DoctorDetailsData({
        this.id,
        this.name,
        this.address,
        this.phoneNumber,
        this.cityId,
        this.imagePath,
        this.doctorSpecialistId,
        this.city,
        this.doctorSpecialist,
        this.doctorTimeTable,
    });

    int? id;
    String? name;
    String? address;
    String? phoneNumber;
    int? cityId;
    String? imagePath;
    int? doctorSpecialistId;
    DoctorCity? city;
    DoctorDetailsSpecialist? doctorSpecialist;
    List<DoctorTimeTable>? doctorTimeTable;

    factory DoctorDetailsData.fromJson(Map<String, dynamic> json) => DoctorDetailsData(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        cityId: json["cityId"],
        imagePath: json["imagePath"],
        doctorSpecialistId: json["doctorSpecialistId"],
        city: DoctorCity.fromJson(json["city"]),
        doctorSpecialist: DoctorDetailsSpecialist.fromJson(json["doctorSpecialist"]),
        doctorTimeTable: List<DoctorTimeTable>.from(json["doctorTimeTable"].map((x) => DoctorTimeTable.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phoneNumber": phoneNumber,
        "cityId": cityId,
        "imagePath": imagePath,
        "doctorSpecialistId": doctorSpecialistId,
        "city": city!.toJson(),
        "doctorSpecialist": doctorSpecialist!.toJson(),
        "doctorTimeTable": List<dynamic>.from(doctorTimeTable!.map((x) => x.toJson())),
    };
}

class DoctorCity {
    DoctorCity({
        this.id,
        this.order,
        this.createdDate,
        this.updatedDate,
        this.isActive,
        this.isDeleted,
        this.createdBy,
        this.updatedBy,
        this.name,
        this.suppliers,
        this.doctors,
        this.services,
    });

    int? id;
    dynamic order;
    String? createdDate;
    String? updatedDate;
    bool? isActive;
    bool? isDeleted;
    dynamic createdBy;
    dynamic updatedBy;
    String? name;
    List<dynamic>? suppliers;
    dynamic doctors;
    dynamic services;

    factory DoctorCity.fromJson(Map<String, dynamic> json) => DoctorCity(
        id: json["id"],
        order: json["order"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        name: json["name"],
        suppliers: List<dynamic>.from(json["suppliers"].map((x) => x)),
        doctors: json["doctors"],
        services: json["services"],
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
        "name": name,
        "suppliers": List<dynamic>.from(suppliers!.map((x) => x)),
        "doctors": doctors,
        "services": services,
    };
}

class DoctorDetailsSpecialist {
    DoctorDetailsSpecialist({
        this.id,
        this.name,
        this.doctors,
    });

    int? id;
    String? name;
    dynamic doctors;

    factory DoctorDetailsSpecialist.fromJson(Map<String, dynamic> json) => DoctorDetailsSpecialist(
        id: json["id"],
        name: json["name"],
        doctors: json["doctors"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "doctors": doctors,
    };
}

class DoctorTimeTable {
    DoctorTimeTable({
        this.id,
        this.doctorId,
        this.doctorDay,
        this.doctorTime,
        this.toDoctorTime,
        this.doctor,
    });

    int? id;
    int? doctorId;
    String? doctorDay;
    String? doctorTime;
    dynamic toDoctorTime;
    dynamic doctor;

    factory DoctorTimeTable.fromJson(Map<String, dynamic> json) => DoctorTimeTable(
        id: json["id"],
        doctorId: json["doctorId"],
        doctorDay: json["doctorDay"],
        doctorTime: json["doctorTime"],
        toDoctorTime: json["toDoctorTime"],
        doctor: json["doctor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "doctorId": doctorId,
        "doctorDay": doctorDay,
        "doctorTime": doctorTime,
        "toDoctorTime": toDoctorTime,
        "doctor": doctor,
    };
}
