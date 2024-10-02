
import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/cubits/all_bannares/all_banners_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AllBannersCubit extends Cubit<AllBannersState> {
  AllBannersCubit() : super(AllBannersInitial());

  static AllBannersCubit get(context) => BlocProvider.of(context);

  List<String> banners = [];

  getAllBanners() {
    emit(GetAllBannersLoadingState());
    DioHelper.getData(
      url: EndPoints.getBanners,
    ).then((value) async {
      if (value.statusCode == 200) {
        banners.clear();
        for (int i = 0; i < value.data["banners"].length; i++) {
          banners.add(EndPoints.banners + value.data["banners"][i]["banner"]);
        }
        emit(GetAllBannersSuccessState());
      } else {
        emit(GetAllBannersErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAllBannersErrorState());
    });
  }


}
