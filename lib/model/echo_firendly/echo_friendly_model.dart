import 'dart:convert';

import '../../core/services/remote/dio/end_points.dart';

class EchoFiendlyModel {
  final int? id;
  final String? name;
  final String? name2;
  final String? description;
  final String? materia;
  final String? dimension;
  final String? usage;
  final String? shape;
  final String? paperType;
  final String? categoryId;
  final String? image;
  final String? status;
  final String? colorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;

  EchoFiendlyModel({
    this.id,
    this.name,
    this.name2,
    this.description,
    this.materia,
    this.dimension,
    this.usage,
    this.shape,
    this.paperType,
    this.categoryId,
    this.image,
    this.status,
    this.colorId,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory EchoFiendlyModel.fromJson(String str) =>
      EchoFiendlyModel.fromJson(json.decode(str));

  String toJson() => json.encode(toJson());

  factory EchoFiendlyModel.fromMap(Map<String, dynamic> json) =>
      EchoFiendlyModel(
        id: json["id"],
        name: json["name"],
        name2: json["name2"],
        description: json["description"],
        materia: json["materia"],
        dimension: json["dimension"],
        usage: json["usage"],
        shape: json["shape"],
        paperType: json["paper_type"],
        categoryId: json["category_id"].toString(),
        image: EndPoints.products + json['image'][0],
        status: json["status"],
        colorId: json["color_id"].toString(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        category: json["category"] == null
            ? null
            : Category.fromMap(json["category"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "name2": name2,
        "description": description,
        "materia": materia,
        "dimension": dimension,
        "usage": usage,
        "shape": shape,
        "paper_type": paperType,
        "category_id": categoryId,
        "image": image,
        "status": status,
        "color_id": colorId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category?.toJson(),
      };
}

class Category {
  final int? id;
  final String? name;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: EndPoints.categories + json["image"],
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
