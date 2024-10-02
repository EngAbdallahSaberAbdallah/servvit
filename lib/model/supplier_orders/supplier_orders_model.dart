class SupplierOrdersModel {
  String? message;
  List<Data>? data;

  SupplierOrdersModel.fromJson(Map<String, dynamic> json) {
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
  String? orderId;
  String? supplierProductSizeId;
  String? customizeProductId;
  String? clientId;
  String? quantity;
  String? halfPrice;
  String? design;
  String? designImage;
  String? customizeImage;
  String? designCost;
  String? clientStatus;
  String? finalCost;
  String? type;
  String? sample;
  String? paymentTerm;
  String? status;
  String? createdAt;
  String? updatedAt;
  SupplierProductSize? supplierProductSize;
  Clients? clients;
  Orders? orders;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'].toString();
    supplierProductSizeId = json['supplier_product_size_id'].toString();
    customizeProductId = json['customize_product_id'].toString();
    clientId = json['client_id'].toString();
    quantity = json['quantity'].toString();
    halfPrice = json['half_price'].toString();
    design = json['design'];
    designImage = json['design_image'];
    customizeImage = json['customize_image'];
    designCost = json['design_cost'].toString();
    clientStatus = json['client_status'].toString();
    finalCost = json['final_cost'].toString();
    type = json['type'];
    sample = json['sample'];
    paymentTerm = json['payment_term'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    supplierProductSize = json['supplier_product_size'] != null
        ? new SupplierProductSize.fromJson(json['supplier_product_size'])
        : null;
    clients =
        json['clients'] != null ? new Clients.fromJson(json['clients']) : null;
    orders =
        json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
  }
}

class SupplierProductSize {
  int? id;
  String? supplierProductId;
  String? sizeId;
  String? minQuantity;
  String? quantity1;
  String? quantity2;
  String? quantity3;
  String? price1;
  String? price2;
  String? price3;
  String? from;
  String? to;
  String? createdAt;
  String? updatedAt;
  SupplierProduct? supplierProduct;
  Sizes? sizes;

  SupplierProductSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierProductId = json['supplier_product_id'].toString();
    sizeId = json['size_id'].toString();
    minQuantity = json['min_quantity'].toString();
    quantity1 = json['quantity1'].toString();
    quantity2 = json['quantity2'].toString();
    quantity3 = json['quantity3'].toString();
    price1 = json['price1'].toString();
    price2 = json['price2'].toString();
    price3 = json['price3'].toString();
    from = json['from'].toString();
    to = json['to'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
  Products? products;

  SupplierProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierId = json['supplier_id'].toString();
    productId = json['product_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }
}

class Products {
  int? id;
  String? name;
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
  Category? category;
  Color? color;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    color = json['color'] != null ? new Color.fromJson(json['color']) : null;
  }
}

class Category {
  int? id;
  String? name;
  String? image;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
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

class Sizes {
  int? id;
  String? size;
  String? createdAt;
  String? updatedAt;

  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Clients {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? image;
  String? governorateId;
  Color? governorate;

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    image = json['image'];
    governorateId = json['governorate_id'].toString();
    governorate = json['governorate'] != null
        ? new Color.fromJson(json['governorate'])
        : null;
  }
}

class Orders {
  int? id;
  String? clientId;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? address;
  String? commercialRegisterNumber;
  String? governorateId;
  String? paymentStatus;
  String? type;
  String? cobonId;
  String? totalCost;
  String? totalCostAfterPayment;
  String? createdAt;
  String? updatedAt;
  Cobon? cobon;

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    image = json['image'].toString();
    address = json['address'].toString();
    commercialRegisterNumber = json['commercial_register_number'].toString();
    governorateId = json['governorate_id'].toString();
    paymentStatus = json['payment_status'].toString();
    type = json['type'];
    cobonId = json['cobon_id'].toString();
    totalCost = json['total_cost'].toString();
    totalCostAfterPayment = json['total_cost_after_payment'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cobon = json['cobon'] != null ? new Cobon.fromJson(json['cobon']) : null;
  }
}

class Cobon {
  int? id;
  String? coboneName;
  String? code;
  String? percentage;
  String? createdAt;
  String? updatedAt;

  Cobon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coboneName = json['cobone_name'];
    code = json['code'].toString();
    percentage = json['percentage'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
