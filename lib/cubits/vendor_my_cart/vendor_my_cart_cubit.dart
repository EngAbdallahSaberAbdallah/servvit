import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../core/services/remote/dio/dio_helper.dart';
import '../../core/services/remote/dio/end_points.dart';
import '../../model/vendor_cart_model/vendor_cart_model.dart';

part 'vendor_my_cart_state.dart';

class VendorMyCartCubit extends Cubit<VendorMyCartState> {
  VendorMyCartCubit() : super(VendorMyCartInitial());

  static VendorMyCartCubit get(context) => BlocProvider.of(context);

  /// get mycart
  List<VendorCartModel> allProductsInCart = [];
  List<VendorCartModel> productsWithWithoutDonate = [];
  //! seperated
  List<VendorCartModel> notDesignedProducts = [];
  List<VendorCartModel> designedProducts = [];
  List<VendorCartModel> donatedProducts = [];
  List<VendorCartModel> customizedProductsInCart = [];
  dynamic totalWithoutVat;
  dynamic vat;
  dynamic totalAfterVat;
  VendorCartModel? vendorCartModel;
  void getMyCart() async {
    emit(VendorMyCartLoading());
    try {
      final response = await DioHelper.getData(
        url: EndPoints.getMyCart,
        sendAuthToken: true,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        vendorCartModel = VendorCartModel.fromJson(response.data);
        totalWithoutVat = response.data["total_without_vat"];
        vat = response.data["vat"];
        totalAfterVat = response.data["total_after_vat"];
        allProductsInCart.clear();
        productsWithWithoutDonate.clear();
        customizedProductsInCart.clear();
        allProductsInCart = (response.data['cart'] as List)
            .map<VendorCartModel>((e) => VendorCartModel.fromJson(e))
            .toList();
        (response.data['cart'] as List).forEach(
          (element) {
            element['type'] == 'product'
                ? productsWithWithoutDonate
                    .add(VendorCartModel.fromJson(element))
                : customizedProductsInCart
                    .add(VendorCartModel.fromJson(element));
          },
        );

        designedProducts = productsWithWithoutDonate.where((product) {
          return product.design == 'with';
        }).toList();
        donatedProducts = productsWithWithoutDonate.where((product) {
          return product.design == 'with_donate';
        }).toList();
        //! without
        notDesignedProducts = productsWithWithoutDonate.where((product) {
          return product.design == 'without';
        }).toList();

        emit(VendorMyCartSuccess());
      } else {
        emit(VendorMyCartError(response.statusMessage!));
      }
    } catch (e) {
      print(e);
      emit(VendorMyCartError(e.toString()));
      rethrow;
      
    }
  }

  /// delete from cart
  Future deleteFromCart({required int cartId}) async {
    emit(VendorMyCartDeleteLoading());
    try {
      final response = await DioHelper.postForm(
        url: EndPoints.deleteFromCart,
        data: FormData.fromMap(
          {
            'cart_id': cartId,
          },
        ),
        sendAuthToken: true,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        getMyCart();
        emit(VendorMyCartDeleteSuccess(response.data['message']));
      } else {
        emit(VendorMyCartDeleteError(response.data['message']));
      }
    } catch (e) {
      emit(VendorMyCartDeleteError(e.toString()));
      rethrow;
    }
  }
}
