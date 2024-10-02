

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/remote/dio/dio_helper.dart';
import '../../core/services/remote/dio/end_points.dart';
import '../../model/customize_request/customize_request_model.dart';
import '../../model/general_request/general_request_model.dart';
import 'cancel_request_states.dart';

class CancelRequestCubit extends Cubit<CancelRequestState> {
  CancelRequestCubit() : super(CancelRequestInitState());

  static CancelRequestCubit get(context) => BlocProvider.of(context);
  GeneralRequestModel? generalRequestModel;
  void CancelRequests({required String productId}) async {
    emit(CancelRequestLoadingState());
    DioHelper.postData(
      url: EndPoints.cancelRequest,
      sendAuthToken: true,
      data:{
        "customize_product_id":productId,
      }
    ).then((value) async {
      if (value.statusCode == 200) {
        generalRequestModel=GeneralRequestModel.fromJson(value.data);
        emit(CancelRequestSuccessState());
      } else {
        emit(CancelRequestErrorState('server error'));
      }
    }).catchError((error) {
      emit(CancelRequestErrorState(error.toString()));
    });
  }

}
