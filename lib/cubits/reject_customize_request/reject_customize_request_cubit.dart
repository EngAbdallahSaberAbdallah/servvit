

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/remote/dio/dio_helper.dart';
import '../../core/services/remote/dio/end_points.dart';
import '../../model/customize_request/customize_request_model.dart';
import '../../model/general_request/general_request_model.dart';
import 'reject_customize_request_states.dart';

class RejectCustomizeRequestCubit extends Cubit<RejectCustomizeRequestState> {
  RejectCustomizeRequestCubit() : super(RejectCustomizeRequestInitState());

  static RejectCustomizeRequestCubit get(context) => BlocProvider.of(context);
  GeneralRequestModel? generalRequestModel;
  void RejectCustomizeRequests({required String productId}) async {
    emit(RejectCustomizeRequestLoadingState());
    DioHelper.postData(
      url: EndPoints.rejectCustomizeRequests,
      sendAuthToken: true,
      data:{
        "customize_product_id":productId,
      }
    ).then((value) async {
      if (value.statusCode == 200) {
        generalRequestModel=GeneralRequestModel.fromJson(value.data);
        emit(RejectCustomizeRequestSuccessState());
      } else {
        emit(RejectCustomizeRequestErrorState('server error'));
      }
    }).catchError((error) {
      emit(RejectCustomizeRequestErrorState(error.toString()));
    });
  }

}
