import 'dart:convert';

import '../../core/services/remote/dio/end_points.dart';

class VendorCartModel {
  final int? id;
  final String? supplierProductSizeId;
  final dynamic customizeProductId;
  final String? clientId;
  final String? supplierId;
  final String? supplierGovernorateId;
  final String? quantity;
  final String? design;
  final dynamic designImage;
  final String? designCost;
  final String? percentage;
  final String? sample;
  final String? type;
  final String? paymentTerm;
  final dynamic customizeImage;
  final String? shippingCost;
  final String? halfPrice;
  final String? totalCostWithoutShipping;
  final String? totalCost;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? pieceCost;
  final SupplierProductSize? supplierProductSize;
  final CustomizeProduct? customizeProduct;
  final dynamic totalWithoutVat; // error
  final dynamic vat; // error -> int
  final dynamic totalAfterVat; // error -> int
  final dynamic half; // error -> string

  VendorCartModel({
    this.id,
    this.supplierProductSizeId,
    this.customizeProductId,
    this.clientId,
    this.supplierId,
    this.supplierGovernorateId,
    this.quantity,
    this.design,
    this.designImage,
    this.designCost,
    this.percentage,
    this.sample,
    this.type,
    this.paymentTerm,
    this.customizeImage,
    this.shippingCost,
    this.halfPrice,
    this.totalCostWithoutShipping,
    this.totalCost,
    this.createdAt,
    this.updatedAt,
    this.pieceCost,
    this.supplierProductSize,
    this.customizeProduct,
    this.totalWithoutVat,
    this.vat,
    this.totalAfterVat,
    this.half,
  });

  factory VendorCartModel.fromRawJson(String str) =>
      VendorCartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VendorCartModel.fromJson(Map<String, dynamic> json) =>
      VendorCartModel(
        id: json["id"],
        supplierProductSizeId: json["supplier_product_size_id"].toString(),
        customizeProductId: json["customize_product_id"].toString(),
        clientId: json["client_id"].toString(),
        supplierId: json["supplier_id"].toString(),
        supplierGovernorateId: json["supplier_governorate_id"].toString(),
        quantity: json["quantity"].toString(),
        design: json["design"].toString(),
        designImage: json["design_image"],
        designCost: json["design_cost"].toString(),
        percentage: json["percentage"].toString(),
        sample: json["sample"].toString(),
        type: json["type"].toString(),
        paymentTerm: json["payment_term"],
        customizeImage: json["customize_image"] == null ||
                json["customize_image"] == "null" ||
                json["customize_image"] == ""
            ? null
            : (json["customize_image"] is String)
                ? EndPoints.customized + json["customize_image"]
                : json["customize_image"] is List<dynamic> &&
                        json["customize_image"] != [] &&
                        json["customize_image"].isNotEmpty
                    ? EndPoints.customized +
                        (json["customize_image"] as List<dynamic>)
                            .map((e) => e)
                            .first
                            .toString()
                    : json["customize_image"] == []
                        ? EndPoints.customized + json["customize_image"]
                        : "",
        shippingCost: json["shipping_cost"].toString(),
        halfPrice: json["half_price"].toString(),
        totalCostWithoutShipping:
            json["total_cost_without_shipping"].toString(),
        totalCost: json["total_cost"].toString(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : (json["updated_at"] is String)
                ? DateTime.parse(json["updated_at"])
                : json["updated_at"] is List<dynamic>
                    ? DateTime.parse((json["updated_at"] as List<dynamic>)
                        .map((e) => e)
                        .first
                        .toString())
                    : json["updated_at"] == []
                        ? DateTime.parse(json["updated_at"])
                        : DateTime.now(),
        // DateTime.parse(json["updated_at"]),
        pieceCost: json["piece_cost"].toString(),
        supplierProductSize: json["supplier_product_size"] == null
            ? null
            : SupplierProductSize.fromJson(json["supplier_product_size"]),
        customizeProduct: json["customize_product"] == null
            ? null
            : CustomizeProduct.fromJson(json["customize_product"]),
        totalWithoutVat: json["total_without_vat"].toString(),
        vat: json["vat"].toString(),
        totalAfterVat: json["total_after_vat"].toString(),
        half: json["half"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "supplier_product_size_id": supplierProductSizeId,
        "customize_product_id": customizeProductId,
        "client_id": clientId,
        "supplier_id": supplierId,
        "supplier_governorate_id": supplierGovernorateId,
        "quantity": quantity,
        "design": design,
        "design_image": designImage,
        "design_cost": designCost,
        "percentage": percentage,
        "sample": sample,
        "type": type,
        "payment_term": paymentTerm,
        "customize_image": customizeImage,
        "shipping_cost": shippingCost,
        "half_price": halfPrice,
        "total_cost_without_shipping": totalCostWithoutShipping,
        "total_cost": totalCost,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "piece_cost": pieceCost,
        "supplier_product_size": supplierProductSize?.toJson(),
        "customize_product": customizeProduct?.toJson(),
        "total_without_vat": totalWithoutVat,
        "vat": vat,
        "total_after_vat": totalAfterVat,
        "half": half,
      };
}

class SupplierProductSize {
  final int? id;
  final String? supplierProductId;
  final String? sizeId;
  final String? minQuantity;
  final dynamic minQuantity2;
  final String? quantity1;
  final dynamic quantity2;
  final dynamic quantity3;
  final String? price1;
  final dynamic price2;
  final dynamic price3;
  final String? from;
  final String? to;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SupplierProduct? supplierProduct;
  final Sizes? sizes;

  SupplierProductSize({
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
    this.supplierProduct,
    this.sizes,
  });

  factory SupplierProductSize.fromRawJson(String str) =>
      SupplierProductSize.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SupplierProductSize.fromJson(Map<String, dynamic> json) =>
      SupplierProductSize(
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
        "supplier_product": supplierProduct?.toJson(),
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
        supplierId: json["supplier_id"].toString(),
        productId: json["product_id"].toString(),
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
  final dynamic name2;
  final String? description;
  final String? materia;
  final String? dimension;
  final dynamic usage;
  final dynamic shape;
  final dynamic paperType;
  final String? categoryId;
  final List<String>? image;
  final String? status;
  final String? colorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;
  final Suppliers? color;

  Products({
    this.id,
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
    this.category,
    this.color,
  });

  factory Products.fromRawJson(String str) =>
      Products.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        name: json["name"],
        name2: json["name2"],
        description: json["description"],
        materia: json["materia"],
        dimension: json["dimension"],
        usage: json["usage"],
        shape: json["shape"],
        paperType: json["paper_type"],
        categoryId: json["category_id"].toString(),
        image: json["image"] == null
            ? null
            : (json['image'] as List).map((element) {
                return EndPoints.products + element;
              }).toList(),
        status: json["status"],
        colorId: json["color_id"].toString(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        color: json["color"] == null ? null : Suppliers.fromJson(json["color"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name2": name2,
        "description": description,
        "materia": materia,
        "dimension": dimension,
        "usage": usage,
        "shape": shape,
        "paper_type": paperType,
        "category_id": categoryId,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "status": status,
        "color_id": colorId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category?.toJson(),
        "color": color?.toJson(),
      };
}

class Category {
  final int? id;
  final String? name;
  final String? image;

  Category({
    this.id,
    this.name,
    this.image,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
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

class CustomizeProduct {
  final int? id;
  final String? clientId;
  final String? size;
  final dynamic description;
  final String? dimension;
  final String? shape;
  final String? color;
  final String? image;
  final String? quantity;
  final String? categoryId;
  final String? isOther;
  final String? otherType;
  final String? price;
  final String? shippingCost;
  final String? totalCostWithoutShipping;
  final String? totalPrice;
  final String? paymentTerm;
  final String? status;
  final String? sentStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CustomizeProduct({
    this.id,
    this.clientId,
    this.size,
    this.description,
    this.dimension,
    this.shape,
    this.color,
    this.image,
    this.quantity,
    this.categoryId,
    this.isOther,
    this.otherType,
    this.price,
    this.shippingCost,
    this.totalCostWithoutShipping,
    this.totalPrice,
    this.paymentTerm,
    this.status,
    this.sentStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomizeProduct.fromRawJson(String str) =>
      CustomizeProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomizeProduct.fromJson(Map<String, dynamic> json) =>
      CustomizeProduct(
        id: json["id"],
        clientId: json["client_id"].toString(),
        size: json["size"].toString(),
        description: json["description"],
        dimension: json["dimension"].toString(),
        shape: json["shape"],
        color: json["color"],
        image: (json["image"] is String)
            ? EndPoints.customized + json["image"]
            : json["customize_image"] is List<dynamic> &&
                    json["customize_image"] != [] &&
                    json["customize_image"].isNotEmpty
                ? EndPoints.customized +
                    (json["customize_image"] as List<dynamic>)
                        .map((e) => e)
                        .first
                        .toString()
                : json["customize_image"] == []
                    ? EndPoints.customized + json["customize_image"]
                    : "",
        quantity: json["quantity"].toString(),
        categoryId: json["category_id"].toString(),
        isOther: json["is_other"],
        otherType: json["other_type"],
        price: json["price"].toString(),
        shippingCost: json["shipping_cost"].toString(),
        totalCostWithoutShipping:
            json["total_cost_without_shipping"].toString(),
        totalPrice: json["total_price"].toString(),
        paymentTerm: json["payment_term"],
        status: json["status"],
        sentStatus: json["sent_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "size": size,
        "description": description,
        "dimension": dimension,
        "shape": shape,
        "color": color,
        "image": image,
        "quantity": quantity,
        "category_id": categoryId,
        "is_other": isOther,
        "other_type": otherType,
        "price": price,
        "shipping_cost": shippingCost,
        "total_cost_without_shipping": totalCostWithoutShipping,
        "total_price": totalPrice,
        "payment_term": paymentTerm,
        "status": status,
        "sent_status": sentStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
