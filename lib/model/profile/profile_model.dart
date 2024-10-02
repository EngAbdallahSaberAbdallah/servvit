// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:echo/core/services/remote/dio/end_points.dart';

class ProfileModel {
  final Data? data;

  ProfileModel({
    this.data,
  });

  factory ProfileModel.fromRawJson(String str) =>
      ProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };

  @override
  String toString() => 'ProfileModel(data: $data)';
}

class Data {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? governorateId;
  final String? address;
  final String? businessName;
  final String? businessTypeId;
  final dynamic image;
  final String? deviceToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BusinessType? businessType;
  final Governorate? governorate;

  Data({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.governorateId,
    this.address,
    this.businessName,
    this.businessTypeId,
    this.image,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
    this.businessType,
    this.governorate,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        governorateId: json["governorate_id"].toString(),
        address: json["address"],
        businessName: json["business_name"],
        businessTypeId: json["business_type_id"].toString(),
        image: json["image"] != null ? json["image"] : null,
        deviceToken: json["device_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        businessType: json["business_type"] == null
            ? null
            : BusinessType.fromJson(json["business_type"]),
        governorate: json["governorate"] == null
            ? null
            : Governorate.fromJson(json["governorate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "governorate_id": governorateId,
        "address": address,
        "business_name": businessName,
        "business_type_id": businessTypeId,
        "image": image,
        "device_token": deviceToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "business_type": businessType?.toJson(),
        "governorate": governorate?.toJson(),
      };

  @override
  String toString() {
    return 'Data(id: $id, name: $name, email: $email, password: $password, phone: $phone, governorateId: $governorateId, address: $address, businessName: $businessName, businessTypeId: $businessTypeId, image: $image, deviceToken: $deviceToken, createdAt: $createdAt, updatedAt: $updatedAt, businessType: $businessType, governorate: $governorate)';
  }
}

class BusinessType {
  final int? id;
  final String? name;

  BusinessType({
    this.id,
    this.name,
  });

  factory BusinessType.fromRawJson(String str) =>
      BusinessType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Governorate {
  int? id;
  String? name;

  Governorate({this.id, this.name});

  Governorate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
