import 'dart:convert';

import '../../core/services/remote/dio/end_points.dart';

class ProductModel {
  final String? message;
  final List<Data>? data;

  ProductModel({
    this.message,
    this.data,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  final int? id;
  final String? name;
  final String? name2;
  final String? description;
  final String? materia;
  final String? dimension;
  final dynamic usage;
  final dynamic shape;
  final dynamic paperType;
  final String? categoryId;
  final List<String>? image;
  final String? status;
  final String? colorId;
  final String? designStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? maxPrice;
  final Category? category;
  final Color? color;
  final String? minPrice;

  Data({
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
    this.designStatus,
    this.createdAt,
    this.updatedAt,
    this.maxPrice,
    this.category,
    this.color,
    this.minPrice,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        image: json["image"] == null
            ? null
            : (json['image'] as List).map((element) {
                return EndPoints.products + element;
              }).toList(),
        status: json["status"],
        colorId: json["color_id"].toString(),
        designStatus: json["design_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        maxPrice: json["max_price"].toString(),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        color: json["color"] == null ? null : Color.fromJson(json["color"]),
        minPrice: json["min_price"].toString(),
      );

  Map<String, dynamic> toJson() => {
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
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "status": status,
        "color_id": colorId,
        "design_status": designStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "max_price": maxPrice,
        "category": category?.toJson(),
        "color": color?.toJson(),
        "min_price": minPrice,
      };
}

class Category {
  final int? id;
  final String? name;
  final String? image;

  Category({
    this.id,
    this.name,
    this.image,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}

class Color {
  final int? id;
  final String? name;

  Color({
    this.id,
    this.name,
  });

  factory Color.fromRawJson(String str) => Color.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        id: json["id"],
        name: json["name"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
