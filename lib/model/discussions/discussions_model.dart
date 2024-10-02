class DiscussionsModel {
  String? message;
  List<Data>? data;


  DiscussionsModel.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? icon;
  String? createdAt;
  String? updatedAt;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}