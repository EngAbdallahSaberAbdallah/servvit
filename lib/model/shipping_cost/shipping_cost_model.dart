import 'dart:convert';

class ShippingCostModel {
  final String? message;
  final String? totalWithoutVat;
  final String? vat;
  final String? totalAfterVat;
  final String? allShippingCost;
  final String? couponValue;
  final String? totalCost;
  final List<SupplierCost>? supplierCosts;
  final String? half;

  ShippingCostModel({
    this.message,
    this.totalWithoutVat,
    this.vat,
    this.totalAfterVat,
    this.allShippingCost,
    this.couponValue,
    this.totalCost,
    this.supplierCosts,
    this.half,
  });

  factory ShippingCostModel.fromRawJson(String str) =>
      ShippingCostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingCostModel.fromJson(Map<String, dynamic> json) =>
      ShippingCostModel(
        message: json["message"],
        totalWithoutVat: json["total_without_vat"].toString(),
        vat: (json["vat"].toDouble()).toStringAsFixed(2),
        totalAfterVat: (json["total_after_vat"].toDouble()).toStringAsFixed(2),
        allShippingCost:
            (json["all_shipping_cost"].toDouble()).toStringAsFixed(2),
        couponValue: (json["coupon_value"].toDouble()).toStringAsFixed(2),
        totalCost: (json["total_cost"].toDouble()).toStringAsFixed(2),
        supplierCosts: json["supplier_costs"] == null
            ? []
            : List<SupplierCost>.from(
                json["supplier_costs"]!.map((x) => SupplierCost.fromJson(x))),
        half: json["half"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "total_without_vat": totalWithoutVat,
        "vat": vat,
        "total_after_vat": totalAfterVat,
        "all_shipping_cost": allShippingCost,
        "coupon_value": couponValue,
        "total_cost": totalCost,
        "supplier_costs": supplierCosts == null
            ? []
            : List<dynamic>.from(supplierCosts!.map((x) => x.toJson())),
        "half": half,
      };

  @override
  String toString() {
    return 'ShippingCostModel(message: $message, totalWithoutVat: $totalWithoutVat, vat: $vat, totalAfterVat: $totalAfterVat, allShippingCost: $allShippingCost, couponValue: $couponValue, totalCost: $totalCost, supplierCosts: $supplierCosts, half: $half)';
  }
}

class SupplierCost {
  final int? supplier;
  final String? cost;

  SupplierCost({
    this.supplier,
    this.cost,
  });

  factory SupplierCost.fromRawJson(String str) =>
      SupplierCost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SupplierCost.fromJson(Map<String, dynamic> json) => SupplierCost(
        supplier: json["supplier"],
        cost: (json["cost"].toDouble()).toStringAsFixed(2),
      );

  Map<String, dynamic> toJson() => {
        "supplier": supplier,
        "cost": cost,
      };
}
