

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/remote/dio/dio_helper.dart';
import '../../core/services/remote/dio/end_points.dart';
import '../../model/general_request/general_request_model.dart';
import 'add_to_cart_customize_states.dart';

class AddToCartCustomizeRequestCubit extends Cubit<AddToCartCustomizeRequestState> {
  AddToCartCustomizeRequestCubit() : super(AddToCartCustomizeRequestInitState());

  static AddToCartCustomizeRequestCubit get(context) => BlocProvider.of(context);
  GeneralRequestModel? generalRequestModel;
  void AddToCartCustomizeRequests({required String productId}) async {
    emit(GetAddToCartCustomizeRequestLoadingState());
    DioHelper.postData(
      url: EndPoints.AddToCartCustomizeRequests,
      sendAuthToken: true,
      data: {
        "customize_product_id": productId,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        generalRequestModel=GeneralRequestModel.fromJson(value.data);
        emit(GetAddToCartCustomizeRequestSuccessState());
      } else {
        emit(GetAddToCartCustomizeRequestErrorState('server error'));
      }
    }).catchError((error) {
      emit(GetAddToCartCustomizeRequestErrorState(error.toString()));
    });
  }

}
