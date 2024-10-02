
import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/echo_firendly/echo_friendly_model.dart';
import 'eco_friendly_state.dart';

class EcoFriendlyCubit extends Cubit<EcoFriendlyState> {
  EcoFriendlyCubit() : super(EchoFriendlyInitial());

  static EcoFriendlyCubit get(context) => BlocProvider.of(context);


  List<EchoFiendlyModel> echoFriendlyModels = [];
  void getEchoFirendly() async {
    emit(GetEchoFriendlyLoadingState());
    DioHelper.getData(
      url: EndPoints.echoFirendly,
    ).then((value) async {
      if (value.statusCode == 200) {
        echoFriendlyModels = [];
        (value.data['data'] as List).forEach(
              (element) {
            echoFriendlyModels.add(EchoFiendlyModel.fromMap(element));
          },
        );
        emit(GetEchoFriendlySuccessState());
      } else {
        emit(GetEchoFriendlyErrorState('server error'));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetEchoFriendlyErrorState(error.toString()));
    });
  }

}
