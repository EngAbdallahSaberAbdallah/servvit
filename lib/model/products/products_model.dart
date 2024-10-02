// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductsModel {
  String? message;
  List<Data>? data;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  dynamic name2;
  String? description;
  String? materia;
  String? dimension;
  String? usage;
  String? shape;
  String? paperType;
  String? categoryId;
  List<String>? image;
  String? status;
  String? colorId;
  String? createdAt;
  String? updatedAt;
  String? maxPrice;
  Category? category;
  Color? color;
  String? minPrice;

  Data(
      {this.id,
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
      this.maxPrice,
      this.category,
      this.color,
      this.minPrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name2 = json['name2'];
    description = json['description'];
    materia = json['materia'];
    dimension = json['dimension'];
    usage = json['usage'];
    shape = json['shape'];
    paperType = json['paper_type'];
    categoryId = json['category_id'].toString();
    image = json['image'].cast<String>();
    status = json['status'];
    colorId = json['color_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    maxPrice = json['max_price'].toString();
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    color = json['color'] != null ? new Color.fromJson(json['color']) : null;
    minPrice = json['min_price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name2'] = this.name2;
    data['description'] = this.description;
    data['materia'] = this.materia;
    data['dimension'] = this.dimension;
    data['usage'] = this.usage;
    data['shape'] = this.shape;
    data['paper_type'] = this.paperType;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['color_id'] = this.colorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['max_price'] = this.maxPrice;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    data['min_price'] = this.minPrice;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Color {
  int? id;
  String? name;

  Color({this.id, this.name});

  Color.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
