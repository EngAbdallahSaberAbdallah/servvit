class SearchModel {
  String? message;
  List<Categories>? categories;
  List<Products>? products;

  SearchModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }
}

class Categories {
  int? id;
  String? name;
  String? image;

  Categories({this.id, this.name, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

class Products {
  int? id;
  String? name;
  String? name2;
  String? description;
  String? materia;
  String? dimension;
  // Null? usage;
  // Null? shape;
  // Null? paperType;
  String? categoryId;
  List<String>? image;
  String? status;
  String? colorId;
  String? createdAt;
  String? updatedAt;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name2 = json['name2'];
    description = json['description'];
    materia = json['materia'];
    dimension = json['dimension'];
    // usage = json['usage'];
    // shape = json['shape'];
    // paperType = json['paper_type'];
    categoryId = json['category_id'].toString();
    image = json['image'].cast<String>();
    status = json['status'];
    colorId = json['color_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
