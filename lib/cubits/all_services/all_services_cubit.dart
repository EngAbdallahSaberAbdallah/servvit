import 'dart:developer';

import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/service_model/service_model.dart';
import 'all_services_state.dart';

class AllServicesCubit extends Cubit<AllServicesState> {
  AllServicesCubit() : super(AllServicesInitial());

  static AllServicesCubit get(context) => BlocProvider.of(context);

  List<String> services = [
    "assets/images/service1.jpeg",
    "assets/images/service2.jpeg",
    "assets/images/service3.jpeg",
  ];

  List<ServiceModel> allServices = [];
  void getAllServices() async {
    emit(GetAllServicesLoadingState());
    DioHelper.getData(
      url: EndPoints.getAllServices,
    ).then((value) async {
      if (value.statusCode == 200) {
        allServices = [];
        (value.data['data'] as List).forEach(
              (element) {
            allServices.add(ServiceModel.fromMap(element));
          },
        );
        emit(GetAllServicesSuccessState());
      } else {
        emit(GetAllServicesErrorState('server error'));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAllServicesErrorState(error.toString()));
    });
  }

}
