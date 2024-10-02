import 'package:echo/core/services/local/cache_helper/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/remote/dio/dio_helper.dart';
import '../../core/services/remote/dio/end_points.dart';
import '../../model/design_request/design_request_model.dart';
import 'design_request_states.dart';

class DesignRequestCubit extends Cubit<DesignRequestState> {
  DesignRequestCubit() : super(DesignRequestInitState());

  static DesignRequestCubit get(context) => BlocProvider.of(context);
  DesignRequestModel? designRequestModel;
  void getAllDesignRequests() async {
    emit(GetDesignRequestLoadingState());
    DioHelper.getData(url: EndPoints.getAllDesignRequests, sendAuthToken: true)
        .then((value) async {
      if (value.statusCode == 200) {
        designRequestModel = DesignRequestModel.fromJson(value.data);
        emit(GetDesignRequestSuccessState(designRequestModel!));
      } else {
        emit(GetDesignRequestErrorState('server error'));
      }
    }).catchError((error) {
      emit(GetDesignRequestErrorState(error.toString()));
    });
  }

  void designRequestsCount() async {
    emit(GetDesignRequestLoadingState());

    DioHelper.getData(url: EndPoints.getAllDesignRequests, sendAuthToken: true)
        .then((value) async {
      if (value.statusCode == 200) {
        designRequestModel = DesignRequestModel.fromJson(value.data);

        List<dynamic> listOfRequests = value.data['data'];
        int orderPrice = CacheHelper.getData(key: "orderPrice") as int? ?? 0;
        if (orderPrice != listOfRequests.length) {
          CacheHelper.saveData(
            key: "isOrderPriceOpend",
            value: false,
          );

          emit(GetDesignRequestSuccessState(designRequestModel!,
              count: listOfRequests.length - orderPrice));
          CacheHelper.saveData(
            key: "orderPrice",
            value: listOfRequests.length,
          );
        } else {
          CacheHelper.saveData(
            key: "isOrderPriceOpend",
            value: true,
          );
          emit(GetDesignRequestSuccessState(designRequestModel!, count: 0));
        }
      }
    });
  }
}
