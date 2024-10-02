
import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/model/products/vendor_product_model.dart'
    as vendorProductModel;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'all_products_states.dart';

class AllProductsCubit extends Cubit<AllProductsStates> {
  AllProductsCubit() : super(AllProductsInitial());

  static AllProductsCubit get(context) => BlocProvider.of(context);


  vendorProductModel.ProductModel? allProductsModel;

  //* done
  void getAllProducts() async {
    emit(GetAllProductsLoadingState());
    DioHelper.getData(
      url: EndPoints.getAllProducts,
    ).then((value) async {
      if (value.statusCode == 200) {
        allProductsModel =
            await vendorProductModel.ProductModel.fromJson(value.data);

        emit(GetAllProductsSuccessState());
      } else {
        emit(GetAllProductsErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAllProductsErrorState());
    });
  }


}
