class FavoritesModel {
  int? status;
  List<Data>? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
  String? productId;
  String? supplierId;
  String? createdAt;
  String? updatedAt;
  List<ProductSizes>? productSizes;
  Product? product;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'].toString();
    supplierId = json['supplier_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    if (json['product_sizes'] != null) {
      productSizes = <ProductSizes>[];
      json['product_sizes'].forEach((v) {
        productSizes!.add(new ProductSizes.fromJson(v));
      });
    }
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }
}

class ProductSizes {
  int? id;
  String? productId;
  String? sizeId;
  String? createdAt;
  String? updatedAt;
  Sizes? sizes;

  ProductSizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'].toString();
    sizeId = json['size_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    sizes = json['sizes'] != null ? new Sizes.fromJson(json['sizes']) : null;
  }
}

class Sizes {
  int? id;
  String? size;

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  String? material;
  String? usage;
  String? shape;
  String? paperType;
  String? dimension;
  String? categoryId;
  String? colorId;
  List<String>? image;
  String? status;
  Category? category;
  Category? color;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    material = json['material'];
    usage = json['usage'];
    shape = json['shape'];
    paperType = json['paper_type'];
    dimension = json['dimension'];
    categoryId = json['category_id'].toString();
    colorId = json['color_id'].toString();
    image = json['image'].cast<String>();
    status = json['status'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    color = json['color'] != null ? new Category.fromJson(json['color']) : null;
  }
}

class Category {
  int? id;
  String? name;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
