import 'dart:convert';

class VendorRequestModel {
  final int? id;
  final String? supplierProductSizeId;
  final String? clientId;
  final String? quantity;
  final String? design;
  final String? designImage;
  final String? sentStatus;
  final String? clientStatus;
  final String? designCost;
  final String? shippingCost;
  final String? totalCost;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SupplierProductSize? supplierProductSize;

  VendorRequestModel({
    this.id,
    this.supplierProductSizeId,
    this.clientId,
    this.quantity,
    this.design,
    this.designImage,
    this.sentStatus,
    this.clientStatus,
    this.designCost,
    this.shippingCost,
    this.totalCost,
    this.createdAt,
    this.updatedAt,
    this.supplierProductSize,
  });

  factory VendorRequestModel.fromJson(String str) =>
      VendorRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VendorRequestModel.fromMap(Map<String, dynamic> json) =>
      VendorRequestModel(
        id: json["id"],
        supplierProductSizeId: json["supplier_product_size_id"],
        clientId: json["client_id"],
        quantity: json["quantity"],
        design: json["design"],
        designImage: json["design_image"],
        sentStatus: json["sent_status"],
        clientStatus: json["client_status"],
        designCost: json["design_cost"],
        shippingCost: json["shipping_cost"],
        totalCost: json["total_cost"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        supplierProductSize: json["supplier_product_size"] == null
            ? null
            : SupplierProductSize.fromJson(json["supplier_product_size"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "supplier_product_size_id": supplierProductSizeId,
        "client_id": clientId,
        "quantity": quantity,
        "design": design,
        "design_image": designImage,
        "sent_status": sentStatus,
        "client_status": clientStatus,
        "design_cost": designCost,
        "shipping_cost": shippingCost,
        "total_cost": totalCost,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "supplier_product_size": supplierProductSize?.toJson(),
      };
}

class SupplierProductSize {
  final int? id;
  final String? supplierProductId;
  final String? sizeId;
  final String? minQuantity;
  final String? quantity1;
  final String? quantity2;
  final dynamic quantity3;
  final String? price1;
  final String? price2;
  final dynamic price3;
  final String? from;
  final String? to;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SupplierProduct? supplierProduct;
  final Sizes? sizes;

  SupplierProductSize({
    this.id,
    this.supplierProductId,
    this.sizeId,
    this.minQuantity,
    this.quantity1,
    this.quantity2,
    this.quantity3,
    this.price1,
    this.price2,
    this.price3,
    this.from,
    this.to,
    this.createdAt,
    this.updatedAt,
    this.supplierProduct,
    this.sizes,
  });

  factory SupplierProductSize.fromRawJson(String str) =>
      SupplierProductSize.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SupplierProductSize.fromJson(Map<String, dynamic> json) =>
      SupplierProductSize(
        id: json["id"],
        supplierProductId: json["supplier_product_id"],
        sizeId: json["size_id"],
        minQuantity: json["min_quantity"],
        quantity1: json["quantity1"],
        quantity2: json["quantity2"],
        quantity3: json["quantity3"],
        price1: json["price1"],
        price2: json["price2"],
        price3: json["price3"],
        from: json["from"],
        to: json["to"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        supplierProduct: json["supplier_product"] == null
            ? null
            : SupplierProduct.fromJson(json["supplier_product"]),
        sizes: json["sizes"] == null ? null : Sizes.fromJson(json["sizes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "supplier_product_id": supplierProductId,
        "size_id": sizeId,
        "min_quantity": minQuantity,
        "quantity1": quantity1,
        "quantity2": quantity2,
        "quantity3": quantity3,
        "price1": price1,
        "price2": price2,
        "price3": price3,
        "from": from,
        "to": to,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "supplier_product": supplierProduct?.toJson(),
        "sizes": sizes?.toJson(),
      };
}

class Sizes {
  final int? id;
  final String? size;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Sizes({
    this.id,
    this.size,
    this.createdAt,
    this.updatedAt,
  });

  factory Sizes.fromRawJson(String str) => Sizes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        id: json["id"],
        size: json["size"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "size": size,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class SupplierProduct {
  final int? id;
  final String? supplierId;
  final String? productId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Suppliers? suppliers;
  final Products? products;

  SupplierProduct({
    this.id,
    this.supplierId,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.suppliers,
    this.products,
  });

  factory SupplierProduct.fromRawJson(String str) =>
      SupplierProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SupplierProduct.fromJson(Map<String, dynamic> json) =>
      SupplierProduct(
        id: json["id"],
        supplierId: json["supplier_id"],
        productId: json["product_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        suppliers: json["suppliers"] == null
            ? null
            : Suppliers.fromJson(json["suppliers"]),
        products: json["products"] == null
            ? null
            : Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "supplier_id": supplierId,
        "product_id": productId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "suppliers": suppliers?.toJson(),
        "products": products?.toJson(),
      };
}

class Products {
  final int? id;
  final String? name;
  final List<String>? image;

  Products({
    this.id,
    this.name,
    this.image,
  });

  factory Products.fromRawJson(String str) =>
      Products.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        name: json["name"],
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
      };
}

class Suppliers {
  final int? id;
  final String? name;

  Suppliers({
    this.id,
    this.name,
  });

  factory Suppliers.fromRawJson(String str) =>
      Suppliers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Suppliers.fromJson(Map<String, dynamic> json) => Suppliers(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
