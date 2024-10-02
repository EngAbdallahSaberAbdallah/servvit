class DesignRequestModel {
  int? status;
  List<Data>? data;

  DesignRequestModel.fromJson(Map<String, dynamic> json) {
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
  int? supplierProductSizeId;
  String? clientId;
  String? quantity;
  String? design;
  String? designImage;
  String? sentStatus;
  String? clientStatus;
  String? designCost;
  String? percentage;
  String? shippingCost;
  String? totalCostWithoutShipping;
  String? totalCost;
  String? createdAt;
  String? updatedAt;
  SupplierProductSize? supplierProductSize;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierProductSizeId = json['supplier_product_size_id'];
    clientId = json['client_id'].toString();
    quantity = json['quantity'].toString();
    design = json['design'].toString();
    designImage = json['design_image'].toString();
    sentStatus = json['sent_status'].toString();
    clientStatus = json['client_status'].toString();
    designCost = json['design_cost'].toString();
    percentage = json['percentage'].toString();
    shippingCost = json['shipping_cost'].toString();
    totalCostWithoutShipping = json['total_cost_without_shipping'].toString();
    totalCost = json['total_cost'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    supplierProductSize = json['supplier_product_size'] != null
        ? new SupplierProductSize.fromJson(json['supplier_product_size'])
        : null;
  }
}

class SupplierProductSize {
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
  String? to;
  String? status;
  String? createdAt;
  String? updatedAt;
  SupplierProduct? supplierProduct;
  Sizes? sizes;

  SupplierProductSize.fromJson(Map<String, dynamic> json) {
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
    to = json['to'].toString();
    status = json['status'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    supplierProduct = json['supplier_product'] != null
        ? new SupplierProduct.fromJson(json['supplier_product'])
        : null;
    sizes = json['sizes'] != null ? new Sizes.fromJson(json['sizes']) : null;
  }
}

class SupplierProduct {
  int? id;
  String? supplierId;
  String? productId;
  String? createdAt;
  String? updatedAt;
  Suppliers? suppliers;
  Products? products;

  SupplierProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierId = json['supplier_id'].toString();
    productId = json['product_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    suppliers = json['suppliers'] != null
        ? new Suppliers.fromJson(json['suppliers'])
        : null;
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }
}

class Suppliers {
  int? id;
  String? name;

  Suppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Products {
  int? id;
  String? name;
  String? name2;
  List<String>? image;
  String? colorId;
  Suppliers? color;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    name2 = json['name2'].toString();
    image = json['image'].cast<String>();
    colorId = json['color_id'].toString();
    color =
        json['color'] != null ? new Suppliers.fromJson(json['color']) : null;
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
