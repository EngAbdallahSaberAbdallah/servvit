

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/remote/dio/dio_helper.dart';
import '../../core/services/remote/dio/end_points.dart';
import '../../model/customize_request/customize_request_model.dart';
import '../../model/general_request/general_request_model.dart';
import 'reject_designed_request_states.dart';

class RejectDesignedRequestCubit extends Cubit<RejectDesignedRequestState> {
  RejectDesignedRequestCubit() : super(RejectDesignedRequestInitState());

  static RejectDesignedRequestCubit get(context) => BlocProvider.of(context);
  GeneralRequestModel? generalRequestModel;
  void RejectDesignedRequests({required String requestId}) async {
    emit(RejectDesignedRequestLoadingState());
    DioHelper.postData(
      url: EndPoints.rejectDesignedRequests,
      sendAuthToken: true,
      data:{
        "request_id":requestId,
      }
    ).then((value) async {
      if (value.statusCode == 200) {
        generalRequestModel=GeneralRequestModel.fromJson(value.data);
        emit(RejectDesignedRequestSuccessState());
      } else {
        emit(RejectDesignedRequestErrorState('server error'));
      }
    }).catchError((error) {
      emit(RejectDesignedRequestErrorState(error.toString()));
    });
  }

}
