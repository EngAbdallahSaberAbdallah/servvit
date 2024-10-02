class CustomizeRequestModel {
  List<All>? all;

  CustomizeRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['all'] != null) {
      all = <All>[];
      json['all'].forEach((v) {
        all!.add(new All.fromJson(v));
      });
    }
  }
}

class All {
  int? id;
  String? clientId;
  String? size;
  String? description;
  String? dimension;
  String? shape;
  String? color;
  List<String>? image;
  String? quantity;
  String? categoryId;
  String? isOther;
  String? otherType;
  String? price;
  String? shippingCost;
  String? totalCostWithoutShipping;
  String? totalPrice;
  String? paymentTerm;
  String? status;
  String? sentStatus;
  String? createdAt;
  String? updatedAt;
  Category? category;

  All.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'].toString();
    size = json['size'].toString();
    description = json['description'].toString();
    dimension = json['dimension'].toString();
    shape = json['shape'].toString();
    color = json['color'].toString();
    image = json['image'] == null
        ? []
        : List<String>.from(json["image"].map((x) => x));
    quantity = json['quantity'].toString();
    categoryId = json['category_id'].toString();
    isOther = json['is_other'].toString();
    otherType = json['other_type'].toString();
    price = json['price'].toString();
    shippingCost = json['shipping_cost'].toString();
    totalCostWithoutShipping = json['total_cost_without_shipping'].toString();
    totalPrice = json['total_price'].toString();
    paymentTerm = json['payment_term'].toString();
    status = json['status'].toString();
    sentStatus = json['sent_status'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }
}

class Category {
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
