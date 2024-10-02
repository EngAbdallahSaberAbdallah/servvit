import 'dart:convert';

class FavoriteProductModel {
  final int? id;
  final String? productId;
  final String? clientId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProductSize>? productSizes;
  final Product? product;

  FavoriteProductModel({
    this.id,
    this.productId,
    this.clientId,
    this.createdAt,
    this.updatedAt,
    this.productSizes,
    this.product,
  });

  factory FavoriteProductModel.fromRawJson(String str) =>
      FavoriteProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavoriteProductModel.fromJson(Map<String, dynamic> json) =>
      FavoriteProductModel(
        id: json["id"],
        productId: json["product_id"],
        clientId: json["client_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        productSizes: json["product_sizes"] == null
            ? []
            : List<ProductSize>.from(
                json["product_sizes"]!.map((x) => ProductSize.fromJson(x))),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "client_id": clientId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product_sizes": productSizes == null
            ? []
            : List<dynamic>.from(productSizes!.map((x) => x.toJson())),
        "product": product?.toJson(),
      };
}

class Product {
  final int? id;
  final String? name;
  final String? name2;
  final String? description;
  final String? material;
  final dynamic usage;
  final dynamic shape;
  final dynamic paperType;
  final dynamic dimension;
  final String? categoryId;
  final String? colorId;
  final List<String>? image;
  final String? status;
  final Category? category;
  final Category? color;

  Product({
    this.id,
    this.name,
    this.name2,
    this.description,
    this.material,
    this.usage,
    this.shape,
    this.paperType,
    this.dimension,
    this.categoryId,
    this.colorId,
    this.image,
    this.status,
    this.category,
    this.color,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        name2: json["name2"],
        description: json["description"],
        material: json["material"],
        usage: json["usage"],
        shape: json["shape"],
        paperType: json["paper_type"],
        dimension: json["dimension"],
        categoryId: json["category_id"],
        colorId: json["color_id"],
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"]!.map((x) => x)),
        status: json["status"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        color: json["color"] == null ? null : Category.fromJson(json["color"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name2": name2,
        "description": description,
        "material": material,
        "usage": usage,
        "shape": shape,
        "paper_type": paperType,
        "dimension": dimension,
        "category_id": categoryId,
        "color_id": colorId,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "status": status,
        "category": category?.toJson(),
        "color": color?.toJson(),
      };
}

class Category {
  final int? id;
  final String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ProductSize {
  final int? id;
  final String? productId;
  final String? sizeId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Sizes? sizes;

  ProductSize({
    this.id,
    this.productId,
    this.sizeId,
    this.createdAt,
    this.updatedAt,
    this.sizes,
  });

  factory ProductSize.fromRawJson(String str) =>
      ProductSize.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductSize.fromJson(Map<String, dynamic> json) => ProductSize(
        id: json["id"],
        productId: json["product_id"],
        sizeId: json["size_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sizes: json["sizes"] == null ? null : Sizes.fromJson(json["sizes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "size_id": sizeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sizes": sizes?.toJson(),
      };
}

class Sizes {
  final int? id;
  final String? size;

  Sizes({
    this.id,
    this.size,
  });

  factory Sizes.fromRawJson(String str) => Sizes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        id: json["id"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "size": size,
      };
}
