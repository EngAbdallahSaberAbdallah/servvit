
import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/constants.dart';
import '../../model/categories/categories_model.dart';
import 'select_categories_state.dart';



class SelectCategoriesCubit extends Cubit<SelectCategoriesState> {
  SelectCategoriesCubit() : super(SelectCategoriesInitial());

  static SelectCategoriesCubit get(context) => BlocProvider.of(context);

  void selectCategory(int index) {
    catIndex=index;
    emit(SelectCategoryState());
  }


}
