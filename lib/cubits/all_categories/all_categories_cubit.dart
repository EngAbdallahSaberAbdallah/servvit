
import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/categories/categories_model.dart';
import 'all_categories_state.dart';



class AllCategoriesCubit extends Cubit<AllCategoriesState> {
  AllCategoriesCubit() : super(AllCategoriesInitial());

  static AllCategoriesCubit get(context) => BlocProvider.of(context);


  AllCategoriesModel? allCategoriesModel;
  List<String> categories=[];
  List<int> categoriesIDs=[];
  getAllCategories() {
    emit(GetAllCategoriesLoadingState());
    DioHelper.getData(
      url: EndPoints.getAllCategories,
    ).then((value) async {
      if (value.statusCode == 200) {
        categories=[];
        categoriesIDs=[];
        allCategoriesModel = await AllCategoriesModel.fromJson(value.data);
        allCategoriesModel!.data?.forEach((element) {
          categories.add(element.name!);
          categoriesIDs.add(element.id!);
        });
        categories.add("others".tr());
        emit(GetAllCategoriesSuccessState());
      } else {
        emit(GetAllCategoriesErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAllCategoriesErrorState());
    });
  }

}
