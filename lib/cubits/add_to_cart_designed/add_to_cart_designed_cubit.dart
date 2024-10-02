

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/remote/dio/dio_helper.dart';
import '../../core/services/remote/dio/end_points.dart';
import '../../model/general_request/general_request_model.dart';
import 'add_to_cart_designed_states.dart';

class AddToCartDesignedRequestCubit extends Cubit<AddToCartDesignedRequestState> {
  AddToCartDesignedRequestCubit() : super(AddToCartDesignedRequestInitState());

  static AddToCartDesignedRequestCubit get(context) => BlocProvider.of(context);
  GeneralRequestModel? generalRequestModel;
  void AddToCartDesignedRequests({required String productId}) async {
    emit(GetAddToCartDesignedRequestLoadingState());
    DioHelper.postData(
      url: EndPoints.AddToCartDesignedRequests,
      sendAuthToken: true,
      data: {
        "request_id": productId,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        generalRequestModel=GeneralRequestModel.fromJson(value.data);
        emit(GetAddToCartDesignedRequestSuccessState());
      } else {
        emit(GetAddToCartDesignedRequestErrorState('server error'));
      }
    }).catchError((error) {
      emit(GetAddToCartDesignedRequestErrorState(error.toString()));
    });
  }

}
