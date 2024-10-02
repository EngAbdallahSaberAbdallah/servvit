import 'dart:convert';

import 'package:dio/dio.dart';

class AddOrderRequestModel {
  String? name;
  String? phone;
  String? email;
  String? address;
  String? shippingAddress;
  String? commericalRegisterNumber;
  String? governorateId;
  String? device;
  PaymentStatus? paymentStatus;
  String? image;
  String? couponCode;
  AddOrderRequestModel({
    this.name,
    this.phone,
    this.email,
    this.address,
    this.device,
    this.shippingAddress,
    this.commericalRegisterNumber,
    this.governorateId,
    this.paymentStatus,
    this.image,
    this.couponCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'device_type': "mobile",
      'shipping_address': shippingAddress,
      'commercial_register_number': commericalRegisterNumber,
      'governorate_id': governorateId,
      'payment_status': paymentStatus!.text,
      if (image != null) 'image': MultipartFile.fromFile(image!),
      if (couponCode != null) 'code': couponCode,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AddOrderRequestModel(name: $name,device_type:mobile ,phone: $phone, email: $email, address: $address, shippingAddress: $shippingAddress, commericalRegisterNumber: $commericalRegisterNumber, governorateId: $governorateId, paymentStatus: $paymentStatus, image: $image, couponCode: $couponCode)';
  }
}

enum PaymentStatus {
  card('card'),
  transfer('transfer'),
  deleivery('delivery'),
bankDelivery('delivery');

  final String text;
  const PaymentStatus(this.text);
}
