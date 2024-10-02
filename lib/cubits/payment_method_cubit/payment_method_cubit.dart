import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/remote/dio/dio_helper.dart';
import '../../core/services/remote/dio/end_points.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/payment_constants.dart';
import '../../model/request_add_order/add_order_request_model.dart';
import '../../model/shipping_cost/shipping_cost_model.dart';
import '../../model/vendor_cart_model/vendor_cart_model.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodInitial()) {
    paymentOrderRequest = AddOrderRequestModel();
  }

  late AddOrderRequestModel paymentOrderRequest;

  static PaymentMethodCubit get(BuildContext context) {
    // paymentContext = context;
    return BlocProvider.of(context);
  }

  bool showDialog = false;

  static BuildContext? paymentContext;

  String? selectedImage;

  void selectImage() async {
    await pickImageFromGallery().then((value) => selectedImage = value);
    emit(VendorSelectImage());
  }

  ShippingCostModel? shippingCostModel;

  void getShippingCost() async {
    log("payment order request" + paymentOrderRequest.toString());
    emit(GetShippingCostLoadingState());
    try {
      await DioHelper.postForm(
        url: EndPoints.getShippingCost,
        data: FormData.fromMap(
          {
            'governorate_id': paymentOrderRequest.governorateId,
            if (paymentOrderRequest.couponCode != null)
              'code': paymentOrderRequest.couponCode,
          },
        ),
        sendAuthToken: true,
      ).then((response) {
        log('status_code : ${response.statusCode}');

        if (response.statusCode == 200) {
          print('shopping cost data is ${response.data}');
          shippingCostModel = ShippingCostModel.fromJson(response.data);
          emit(GetShippingCostSuccessState());
        } else if (response.statusCode == 422) {
          emit(GetShippingCostFailureState(response.data['message']));
        } else {
          emit(GetShippingCostFailureState(response.statusMessage!));
        }
      });
    } catch (e) {
      emit(GetShippingCostFailureState(e.toString()));
      rethrow;
    }
  }

  void pay() async {
    log(paymentOrderRequest.toMap().toString());
    emit(PayLoadingState());
    try {
      await DioHelper.postForm(
        url: EndPoints.pay,
        data: FormData.fromMap(
          paymentOrderRequest.toMap(),
        ),
        sendAuthToken: true,
      ).then((response) {
        log('==================================================${response.data.toString()}');
        if (response.statusCode == 200) {
          debugPrint(response.data.toString());
          //todo:the response have no data => status code 200
          // merchantId=response.data['order_number'];
          print("jsjsjsjjsjs:${merchantId}");
          emit(PaySuccessState(
              response.data['message'], response.data['order_number']));
        } else {
          emit(PayFailureState("${response.statusMessage}"));
        }
      });
    } catch (e) {
      emit(PayFailureState(e.toString()));
      rethrow;
    }
  }

  void addOrder() async {
    log(paymentOrderRequest.toMap().toString());
    emit(PayLoadingState());
    try {
      await DioHelper.postForm(
        url: EndPoints.pay,
        data: FormData.fromMap(
          paymentOrderRequest.toMap(),
        ),
        sendAuthToken: true,
      ).then((response) {
        if (response.statusCode == 200) {
          debugPrint(response.data.toString());
          //todo:the response have no data => status code 200
          merchantId = response.data['order_number'];
          print(
              "++++++++++++++++++++++++++++++++++++++ khaled1111 +++++++++++++++++++++++++++++++++");
          print("jsjsjsjjsjs:${merchantId}");
          payWithPaymob();
          emit(addOrderSuccessState());
        } else {
          emit(addOrderErrorState());
        }
      });
    } catch (e) {
      emit(PayFailureState(e.toString()));
      rethrow;
    }
  }

  void getFinishedUrl(String url) async {
    print("ffffffffffiiiiiiiinnnnnnn");
    print("tttttttttttt ${url.split('/').last}");
    try {
      await DioHelper.getData(url: url.split('/').last).then((response) {
        debugPrint(response.toString());
        emit(PaymentCardSuccess(bool.parse(response.data['data']['success'])));
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void payWithPaymob({List<VendorCartModel> items = const []}) async {
    emit(PayWithPaymobLoadingState());
    try {
      String authToken = await getAuthToken();

      int orderId = await getOrderId(
        authToken: authToken,
        amount: double.parse(shippingCostModel!.half!),

        // items: items.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
      );

      String paymentKey = await getPaymentToken(
        orderId: orderId,
        authToken: authToken,
        amount: double.parse(
          shippingCostModel!.half!,
        ),

        // double.parse(shippingCostModel!.half != '0'
        //   ? shippingCostModel!.half!
        //     : shippingCostModel!.totalCost!
        //   ),
      );
      if (paymentKey.isNotEmpty) {
        // print("++++++++++++++++++++++++++++++++++++++ khaled +++++++++++++++++++++++++++++++++");
        // print(paymentKey);
        emit(PaymobSuccessState(paymentKey));
      }
    } catch (e) {
      emit(PayFailureState(e.toString()));
      rethrow;
    }
  }

//! get auth token
  Future<String> getAuthToken() async {
    try {
      return await Dio().post(
        PaymentConstants.getAuthEndPoint,
        data: {
          "api_key": PaymentConstants.merchantApiKey,
        },
      ).then((response) {
        return response.data['token'];
      });
    } catch (e) {
      emit(PayFailureState(e.toString()));
      rethrow;
    }
  }

  //! get order id
  Future<int> getOrderId({
    required String authToken,
    required double amount,
    // List<Map<String, dynamic>> items = const [],
  }) async {
    try {
      return await Dio().post(
        PaymentConstants.getOrderIdEndPoint,
        data: {
          "auth_token": authToken,
          "delivery_needed": "false",
          "amount_cents": "${100 * amount}", // cent
          "currency": "EGP",
          'merchant_order_id': merchantId,
        },
      ).then((response) {
        print(response.data);
        return response.data['id'];
      });
    } catch (e) {
      emit(PayFailureState(e.toString()));
      rethrow;
    }
  }

  //! get poyment key to set it in the last operation of payment(any card)
  ///
  /// At this step, you will obtain a payment_key token. This key will be used to authenticate your payment request.
  ///  It will be also used for verifying your transaction request metadata.
  ///
  ///  The billing data related to the customer related to this payment.
  /// All the fields in this object are mandatory,
  /// you can send any of these information if it isn't available,
  ///* please send it to be "NA", except, first_name, last_name, email, and phone_number cannot be sent as "NA".
  ///
  ///
  Future<String> getPaymentToken({
    required int orderId,
    required String authToken,
    required double amount,
  }) async {
    try {
      return await Dio().post(
        PaymentConstants.getPaymentKeyEndPoint,
        data: {
          "auth_token": authToken,
          "amount_cents": "${100 * amount}",
          "expiration": 3600,
          // "merchant_order_id":merchantId,
          "order_id": "$orderId",
          "billing_data": {
            "first_name": paymentOrderRequest.name!.split(' ').first,
            "last_name": paymentOrderRequest.name!.split(' ').last,
            "email": paymentOrderRequest.email,
            "phone_number": "+2${paymentOrderRequest.phone}",
            "apartment": "803",
            "floor": "42",
            "street": "Ethan Land",
            "building": "8028",
            "shipping_method": "PKG",
            "postal_code": "01898",
            "city": "Jaskolskiburgh",
            "country": "CR",
          },
          "currency": "EGP",
          "integration_id": PaymentConstants.paymentIntegerationId,
        },
      ).then((response) {
        print("//////////////////////////");
        print(response.data);
        return response.data['token'];
      });
    } catch (e) {
      emit(PayFailureState(e.toString()));
      rethrow;
    }
  }

  void setProgressBarValue(int value) {
    emit(PaymentProgressValue(value));
    if (value == 100) {
      emit(PaymentLoaded());
    }
  }
}
