
import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/cubits/discussion/discussion_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/discussions/discussions_model.dart';


class DiscussionCubit extends Cubit<DiscussionState> {
  DiscussionCubit() : super(DiscussionInitial());

  static DiscussionCubit get(context) => BlocProvider.of(context);

  DiscussionsModel? discussionsModel;
  void getAllDiscussions() async {
    emit(GetAllDiscussionsLoadingState());
    DioHelper.getData(
      url: EndPoints.getAllDiscussions,
    ).then((value) async {
      if (value.statusCode == 200) {
        discussionsModel=DiscussionsModel.fromJson(value.data);
        emit(GetAllDiscussionsSuccessState(discussionsModel!));
      } else {
        emit(GetAllDiscussionsErrorState('server error'));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAllDiscussionsErrorState(error.toString()));
    });
  }


}
