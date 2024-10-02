class SupplierProductsModel {
  String? message;
  List<Data>? data;

  SupplierProductsModel.fromJson(Map<String, dynamic> json) {
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
  String? supplierId;
  String? productId;
  String? createdAt;
  String? updatedAt;
  String? favorite;
  List<ProductSizes>? productSizes;
  Products? products;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierId = json['supplier_id'].toString();
    productId = json['product_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    favorite = json['favorite'].toString();
    if (json['product_sizes'] != null) {
      productSizes = <ProductSizes>[];
      json['product_sizes'].forEach((v) {
        productSizes!.add(new ProductSizes.fromJson(v));
      });
    }
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }
}

class ProductSizes {
  int? id;
  String? supplierProductId;
  String? sizeId;
  String? minQuantity;
  String? minQuantity2;
  String? quantity1;
  String? quantity2;
  String? quantity3;
  String? price1;
  String? price2;
  String? price3;
  String? from;
  String? status;
  String? to;
  String? createdAt;
  String? updatedAt;
  Sizes? sizes;

  ProductSizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierProductId = json['supplier_product_id'].toString();
    sizeId = json['size_id'].toString();
    minQuantity = json['min_quantity'].toString();
    minQuantity2 = json['min_quantity2'].toString();
    quantity1 = json['quantity1'].toString();
    quantity2 = json['quantity2'].toString();
    quantity3 = json['quantity3'].toString();
    price1 = json['price1'].toString();
    price2 = json['price2'].toString();
    price3 = json['price3'].toString();
    from = json['from'].toString();
    status = json['status'].toString();
    to = json['to'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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

class Products {
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
  Color? color;
  Color? category;

  Products.fromJson(Map<String, dynamic> json) {
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
    color = json['color'] != null ? new Color.fromJson(json['color']) : null;
    category =
        json['category'] != null ? new Color.fromJson(json['category']) : null;
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
