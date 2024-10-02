class OrderModel {
  int? status;
  List<Orders>? orders;

  OrderModel({this.status, this.orders});

  OrderModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['status'] = this.status;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? id;
  dynamic clientId;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic image;
  dynamic address;
  dynamic shippingAddress;
  dynamic commercialRegisterNumber;
  dynamic governorateId;
  dynamic paymentStatus;
  dynamic type;
  dynamic cobonId;
  dynamic vat;
  dynamic totalWithoutVat;
  dynamic totalWithVat;
  dynamic shippingCost;
  dynamic couponValue;
  dynamic totalCost;
  dynamic deviceType;
  dynamic createdAt;
  dynamic updatedAt;
  List<OrderItems>? orderItems;
  Suppliers? governorate;

  Orders(
      {this.id,
      this.clientId,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.address,
      this.shippingAddress,
      this.commercialRegisterNumber,
      this.governorateId,
      this.paymentStatus,
      this.type,
      this.cobonId,
      this.vat,
      this.totalWithoutVat,
      this.totalWithVat,
      this.shippingCost,
      this.couponValue,
      this.totalCost,
      this.deviceType,
      this.createdAt,
      this.updatedAt,
      this.orderItems,
      this.governorate});

  Orders.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    image = json['image'];
    address = json['address'].toString();
    shippingAddress = json['shipping_address'].toString();
    commercialRegisterNumber = json['commercial_register_number'].toString();
    governorateId = json['governorate_id'].toString();
    paymentStatus = json['payment_status'].toString();
    type = json['type'];
    cobonId = json['cobon_id'].toString();
    vat = json['vat'].toString();
    totalWithoutVat = json['total_without_vat'].toString();
    totalWithVat = json['total_with_vat'].toString();
    shippingCost = json['shipping_cost'].toString();
    couponValue = json['coupon_value'].toString();
    totalCost = json['total_cost'].toString();
    deviceType = json['device_type'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    governorate = json['governorate'] != null
        ? new Suppliers.fromJson(json['governorate'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['address'] = this.address;
    data['shipping_address'] = this.shippingAddress;
    data['commercial_register_number'] = this.commercialRegisterNumber;
    data['governorate_id'] = this.governorateId;
    data['payment_status'] = this.paymentStatus;
    data['type'] = this.type;
    data['cobon_id'] = this.cobonId;
    data['vat'] = this.vat;
    data['total_without_vat'] = this.totalWithoutVat;
    data['total_with_vat'] = this.totalWithVat;
    data['shipping_cost'] = this.shippingCost;
    data['coupon_value'] = this.couponValue;
    data['total_cost'] = this.totalCost;
    data['device_type'] = this.deviceType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    if (this.governorate != null) {
      data['governorate'] = this.governorate!.toJson();
    }
    return data;
  }
}

class OrderItems {
  int? id;
  dynamic orderId;
  dynamic supplierProductSizeId;
  dynamic customizeProductId;
  dynamic clientId;
  dynamic quantity;
  dynamic halfPrice;
  dynamic design;
  dynamic designImage;
  List<dynamic>? customizeImage;
  dynamic designCost;
  dynamic totalCostWithoutShipping;
  dynamic clientStatus;
  dynamic finalCost;
  dynamic type;
  dynamic sample;
  dynamic paymentTerm;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic pieceCost;
  SupplierProductSize? supplierProductSize;
  CustomizedProduct? customizedProduct;

  OrderItems(
      {this.id,
      this.orderId,
      this.supplierProductSizeId,
      this.customizeProductId,
      this.clientId,
      this.quantity,
      this.halfPrice,
      this.design,
      this.designImage,
      this.customizeImage,
      this.designCost,
      this.totalCostWithoutShipping,
      this.clientStatus,
      this.finalCost,
      this.type,
      this.sample,
      this.paymentTerm,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.pieceCost,
      this.supplierProductSize,
      this.customizedProduct});

  OrderItems.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'].toString();
    supplierProductSizeId = json['supplier_product_size_id'].toString();
    customizeProductId = json['customize_product_id'].toString();
    clientId = json['client_id'].toString();
    quantity = json['quantity'].toString();
    halfPrice = json['half_price'].toString();
    design = json['design'];
    designImage = json['design_image'];
    customizeImage = json["customize_image"] == null
        ? []
        : List<dynamic>.from(json["customize_image"].map((x) => x));
    designCost = json['design_cost'].toString();
    totalCostWithoutShipping = json['total_cost_without_shipping'].toString();
    clientStatus = json['client_status'];
    finalCost = json['final_cost'].toString();
    type = json['type'];
    sample = json['sample'];
    paymentTerm = json['payment_term'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pieceCost = json['piece_cost'].toString();
    supplierProductSize = json.containsKey("supplier_product_size")? json['supplier_product_size'] != null
        ? new SupplierProductSize.fromJson(json['supplier_product_size'])
        : null:null;
    customizedProduct = json['customized_product'] != null
        ? new CustomizedProduct.fromJson(json['customized_product'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['supplier_product_size_id'] = this.supplierProductSizeId;
    data['customize_product_id'] = this.customizeProductId;
    data['client_id'] = this.clientId;
    data['quantity'] = this.quantity;
    data['half_price'] = this.halfPrice;
    data['design'] = this.design;
    data['design_image'] = this.designImage;
    data['customize_image'] = this.customizeImage;
    data['design_cost'] = this.designCost;
    data['total_cost_without_shipping'] = this.totalCostWithoutShipping;
    data['client_status'] = this.clientStatus;
    data['final_cost'] = this.finalCost;
    data['type'] = this.type;
    data['sample'] = this.sample;
    data['payment_term'] = this.paymentTerm;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['piece_cost'] = this.pieceCost;
    if (this.supplierProductSize != null) {
      data['supplier_product_size'] = this.supplierProductSize!.toJson();
    }
    if (this.customizedProduct != null) {
      data['customized_product'] = this.customizedProduct!.toJson();
    }
    return data;
  }
}

class SupplierProductSize {
  int? id;
  dynamic? supplierProductId;
  dynamic? sizeId;
  dynamic? minQuantity;
  dynamic? minQuantity2;
  dynamic? quantity1;
  dynamic? quantity2;
  dynamic? quantity3;
  dynamic? price1;
  dynamic? price2;
  dynamic? price3;
  dynamic? from;
  dynamic? to;
  dynamic? status;
  dynamic? createdAt;
  dynamic? updatedAt;
  SupplierProduct? supplierProduct;
  Sizes? sizes;

  SupplierProductSize(
      {this.id,
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
      this.sizes});

  SupplierProductSize.fromJson(Map<dynamic, dynamic> json) {
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

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['supplier_product_id'] = this.supplierProductId;
    data['size_id'] = this.sizeId;
    data['min_quantity'] = this.minQuantity;
    data['min_quantity2'] = this.minQuantity2;
    data['quantity1'] = this.quantity1;
    data['quantity2'] = this.quantity2;
    data['quantity3'] = this.quantity3;
    data['price1'] = this.price1;
    data['price2'] = this.price2;
    data['price3'] = this.price3;
    data['from'] = this.from;
    data['to'] = this.to;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.supplierProduct != null) {
      data['supplier_product'] = this.supplierProduct!.toJson();
    }
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.toJson();
    }
    return data;
  }
}

class SupplierProduct {
  int? id;
  dynamic? supplierId;
  dynamic? productId;
  dynamic? createdAt;
  dynamic? updatedAt;
  Suppliers? suppliers;
  Products? products;

  SupplierProduct(
      {this.id,
      this.supplierId,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.suppliers,
      this.products});

  SupplierProduct.fromJson(Map<dynamic, dynamic> json) {
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

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['supplier_id'] = this.supplierId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.suppliers != null) {
      data['suppliers'] = this.suppliers!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }
}

class Suppliers {
  int? id;
  dynamic? name;

  Suppliers({this.id, this.name});

  Suppliers.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Products {
  int? id;
  dynamic? name;
  dynamic? name2;
  dynamic? description;
  dynamic? materia;
  dynamic? dimension;
  dynamic? usage;
  dynamic? shape;
  dynamic? paperType;
  dynamic? categoryId;
  List<dynamic>? image;
  dynamic? status;
  dynamic? colorId;

  Products(
      {this.id,
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
      this.colorId});

  Products.fromJson(Map<dynamic, dynamic> json) {
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
    image = json['image'].cast<dynamic>();
    status = json['status'];
    colorId = json['color_id'].toString();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name2'] = this.name2;
    data['description'] = this.description;
    data['materia'] = this.materia;
    data['dimension'] = this.dimension;
    data['usage'] = this.usage;
    data['shape'] = this.shape;
    data['paper_type'] = this.paperType;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['color_id'] = this.colorId;
    return data;
  }
}

class Sizes {
  int? id;
  dynamic? size;

  Sizes({this.id, this.size});

  Sizes.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    size = json['size'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    return data;
  }
}

class CustomizedProduct {
  int? id;
  dynamic? clientId;
  dynamic? size;
  dynamic? description;
  dynamic? dimension;
  dynamic? shape;
  dynamic? color;
  List<dynamic>? image;
  dynamic? quantity;
  dynamic? categoryId;
  dynamic? isOther;
  dynamic? otherType;
  dynamic? price;
  dynamic? shippingCost;
  dynamic? totalCostWithoutShipping;
  dynamic? totalPrice;
  dynamic? paymentTerm;
  dynamic? status;
  dynamic? sentStatus;
  dynamic? createdAt;
  dynamic? updatedAt;

  CustomizedProduct(
      {this.id,
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
      this.updatedAt});

  CustomizedProduct.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'].toString();
    size = json['size'].toString();
    description = json['description'].toString();
    dimension = json['dimension'].toString();
    shape = json['shape'].toString();
    color = json['color'].toString();
    image = json['image'].cast<dynamic>();
    quantity = json['quantity'].toString();
    categoryId = json['category_id'].toString();
    isOther = json['is_other'];
    otherType = json['other_type'];
    price = json['price'].toString();
    shippingCost = json['shipping_cost'].toString();
    totalCostWithoutShipping = json['total_cost_without_shipping'].toString();
    totalPrice = json['total_price'].toString();
    paymentTerm = json['payment_term'];
    status = json['status'];
    sentStatus = json['sent_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['size'] = this.size;
    data['description'] = this.description;
    data['dimension'] = this.dimension;
    data['shape'] = this.shape;
    data['color'] = this.color;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['category_id'] = this.categoryId;
    data['is_other'] = this.isOther;
    data['other_type'] = this.otherType;
    data['price'] = this.price;
    data['shipping_cost'] = this.shippingCost;
    data['total_cost_without_shipping'] = this.totalCostWithoutShipping;
    data['total_price'] = this.totalPrice;
    data['payment_term'] = this.paymentTerm;
    data['status'] = this.status;
    data['sent_status'] = this.sentStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
