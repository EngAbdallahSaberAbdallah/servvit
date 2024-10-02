import 'package:echo/core/services/remote/dio/end_points.dart';

class AllCategoriesModel {
  String? message;
  List<Data>? data;


  AllCategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = EndPoints.categories + json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
