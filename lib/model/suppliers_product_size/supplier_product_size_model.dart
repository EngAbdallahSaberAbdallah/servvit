import 'dart:convert';

class SupplierProductsModel {
  final String? message;
  final List<Data>? data;

  SupplierProductsModel({
    this.message,
    this.data,
  });

  factory SupplierProductsModel.fromRawJson(String str) =>
      SupplierProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SupplierProductsModel.fromJson(Map<String, dynamic> json) =>
      SupplierProductsModel(
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
  final String? supplierId;
  final String? productId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProductSize>? productSizes;
  final Suppliers? suppliers;

  Data({
    this.id,
    this.supplierId,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.productSizes,
    this.suppliers,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        supplierId: json["supplier_id"].toString(),
        productId: json["product_id"].toString(),
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
        suppliers: json["suppliers"] == null
            ? null
            : Suppliers.fromJson(json["suppliers"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "supplier_id": supplierId,
        "product_id": productId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product_sizes": productSizes == null
            ? []
            : List<dynamic>.from(productSizes!.map((x) => x.toJson())),
        "suppliers": suppliers?.toJson(),
      };
}

class ProductSize {
  final int? id; //! added to sample
  final String? supplierProductId;
  final String? sizeId;
  final String? minQuantity;
  final dynamic minQuantity2;
  final String? quantity1;
  final String? quantity2;
  final String? quantity3;
  final String? price1;
  final String? price2;
  final String? price3;
  final String? from;
  final String? to;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Sizes? sizes;

  ProductSize({
    this.id,
    this.supplierProductId,
    this.sizeId,
    this.minQuantity,
    this.minQuantity2,
    this.quantity1,
    this.quantity2,
    this.quantity3,
    this.price1,
    this.price2,
    this.price3,
    this.from,
    this.to,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.sizes,
  });

  factory ProductSize.fromRawJson(String str) =>
      ProductSize.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductSize.fromJson(Map<String, dynamic> json) => ProductSize(
        id: json["id"],
        supplierProductId: json["supplier_product_id"].toString(),
        sizeId: json["size_id"].toString(),
        minQuantity: json["min_quantity"].toString(),
        minQuantity2: json["min_quantity2"].toString(),
        quantity1: json["quantity1"].toString(),
        quantity2: json["quantity2"].toString(),
        quantity3: json["quantity3"].toString(),
        price1: json["price1"].toString(),
        price2: json["price2"].toString(),
        price3: json["price3"].toString(),
        from: json["from"].toString(),
        to: json["to"].toString(),
        status: json["status"],
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
        "supplier_product_id": supplierProductId,
        "size_id": sizeId,
        "min_quantity": minQuantity,
        "min_quantity2": minQuantity2,
        "quantity1": quantity1,
        "quantity2": quantity2,
        "quantity3": quantity3,
        "price1": price1,
        "price2": price2,
        "price3": price3,
        "from": from,
        "to": to,
        "status": status,
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
        size: json["size"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "size": size,
      };
}

class Suppliers {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? businessName;

  Suppliers({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.businessName,
  });

  factory Suppliers.fromRawJson(String str) =>
      Suppliers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Suppliers.fromJson(Map<String, dynamic> json) => Suppliers(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        businessName: json["business_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "business_name": businessName,
      };
}
