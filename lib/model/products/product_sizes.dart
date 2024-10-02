class ProductSizesModel {
  String? message;
  List<Data>? data;

  ProductSizesModel.fromJson(Map<String, dynamic> json) {
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
  String? name2;
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
  String? otherSize;
  List<ProductSizes>? productSizes;
  Color? color;
  Color? category;

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
    otherSize = json['other_size'].toString();
    if (json['product_sizes'] != null) {
      productSizes = <ProductSizes>[];
      json['product_sizes'].forEach((v) {
        productSizes!.add(new ProductSizes.fromJson(v));
      });
    }
    color = json['color'] != null ? new Color.fromJson(json['color']) : null;
    category =
        json['category'] != null ? new Color.fromJson(json['category']) : null;
  }
}

class ProductSizes {
  int? id;
  String? size;

  ProductSizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'].toString();
  }
}

class Color {
  int? id;
  String? name;

  Color.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
