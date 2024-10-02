import 'dart:convert';

import 'package:echo/core/services/remote/dio/end_points.dart';

class MainCustomerModel {
  final int? id;
  final String? name;
  final String? image;

  MainCustomerModel({
    this.id,
    this.name,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory MainCustomerModel.fromMap(Map<String, dynamic> map) {
    return MainCustomerModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: EndPoints.customers + map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MainCustomerModel.fromJson(String source) =>
      MainCustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
