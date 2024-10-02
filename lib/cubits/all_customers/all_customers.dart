import 'dart:developer';

import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/customer_model/main_customer_model.dart';
import 'all_customers_state.dart';

class AllCustomersCubit extends Cubit<AllCustomersState> {
  AllCustomersCubit() : super(AllCustomersInitial());

  static AllCustomersCubit get(context) => BlocProvider.of(context);


  List<MainCustomerModel> mainCustomerModels = [];
  void getAllCustomers() async {
    emit(GetAllCustomersLoadingState());
    DioHelper.getData(
      url: EndPoints.getAllCustomers,
    ).then((value) async {
      if (value.statusCode == 200) {
        mainCustomerModels = [];
        for (var element in (value.data['data'] as List)) {
          if (element['image'] == null) {
            continue;
          }
          mainCustomerModels.add(MainCustomerModel.fromMap(element));
        }
        emit(GetAllCustomersSuccessState());
      } else {
        emit(GetAllCustomersErrorState('server error'));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      log(error.toString());
      emit(GetAllCustomersErrorState(error.toString()));
    });
  }


}
