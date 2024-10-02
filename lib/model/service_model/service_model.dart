import 'dart:convert';

import 'package:echo/core/services/remote/dio/end_points.dart';

class ServiceModel {
  final int? id;
  final String? name;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ServiceModel({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceModel.fromJson(String str) =>
      ServiceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromMap(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        name: json["name"],
        image: EndPoints.services + json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
