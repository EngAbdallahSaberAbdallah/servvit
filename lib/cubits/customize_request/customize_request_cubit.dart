

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/remote/dio/dio_helper.dart';
import '../../core/services/remote/dio/end_points.dart';
import '../../model/customize_request/customize_request_model.dart';
import 'customize_request_states.dart';

class CustomizeRequestCubit extends Cubit<CustomizeRequestState> {
  CustomizeRequestCubit() : super(CustomizeRequestInitState());

  static CustomizeRequestCubit get(context) => BlocProvider.of(context);
  CustomizeRequestModel? customizeRequestModel;
  void getAllCustomizeRequests() async {
    emit(GetCustomizeRequestLoadingState());
    DioHelper.getData(
      url: EndPoints.getAllCustomizeRequests,
      sendAuthToken: true
    ).then((value) async {
      if (value.statusCode == 200) {
        customizeRequestModel=CustomizeRequestModel.fromJson(value.data);
        emit(GetCustomizeRequestSuccessState(customizeRequestModel!));
      } else {
        emit(GetCustomizeRequestErrorState('server error'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetCustomizeRequestErrorState(error.toString()));
    });
  }

}
