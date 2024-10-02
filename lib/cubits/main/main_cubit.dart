import 'package:dio/dio.dart';
import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/cubits/main/main_state.dart';
import 'package:echo/model/countries/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/reviews/reviews_model.dart';
import '../../model/search/search_suggestions.dart';
import '../../model/technical_support/technical_support_model.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  List<String> services = [
    "assets/images/service1.jpeg",
    "assets/images/service2.jpeg",
    "assets/images/service3.jpeg",
  ];

  ReviewsModel? reviewsModel;
  void getAllReviews() async {
    emit(GetAllReviewsLoadingState());
    DioHelper.getData(
      url: EndPoints.getAllReviews,
    ).then((value) async {
      if (value.statusCode == 200) {
        reviewsModel = ReviewsModel.fromJson(value.data);
        emit(GetAllReviewsSuccessState(reviewsModel!));
      } else {
        emit(GetAllReviewsErrorState('server error'));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAllReviewsErrorState(error.toString()));
    });
  }

  CountryModel? countryModel;
  List<String> countries = [];
  List<int> countriesIDs = [];
  void getAllCountries() async {
    emit(GetAllCountriesLoadingState());
    DioHelper.getData(
      url: EndPoints.getAllCountries,
    ).then((value) async {
      if (value.statusCode == 200) {
        countries = [];
        countriesIDs = [];
        countryModel = CountryModel.fromJson(value.data);
        countryModel!.data?.forEach((element) {
          countries.add(element.name!);
          countriesIDs.add(element.id!);
        });
        print(countries);
        emit(GetAllCountriesSuccessState(countryModel!));
      } else {
        emit(GetAllCountriesErrorState('server error'));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetAllCountriesErrorState(error.toString()));
    });
  }

  TechnicalSupportModel? technicalSupportModel;
  sendRequestToTechnicalSupport({
    required String name,
    required String phone,
    required String email,
    required int countryId,
    required String message,
  }) {
    emit(SendRequestToTechnicalSupportLoadingState());

    DioHelper.postData(
      url: EndPoints.sendTechnicalSupport,
      sendAuthToken: true,
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "governorate_id": countryId,
        "description": message,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        technicalSupportModel = TechnicalSupportModel.fromJson(value.data);
        emit(SendRequestToTechnicalSupportSuccessState());
      } else {
        emit(SendRequestToTechnicalSupportErrorState("Server Error"));
      }
    }).catchError((error) {
      emit(SendRequestToTechnicalSupportErrorState(error));
    });
  }

  sendMyReview({
    required String message,
  }) {
    emit(SendReviewLoadingState());

    DioHelper.postData(
      url: EndPoints.sendReview,
      sendAuthToken: true,
      data: {
        "description": message,
      },
    ).then((value) async {
      if (value.statusCode == 200) {
        technicalSupportModel = TechnicalSupportModel.fromJson(value.data);
        emit(SendReviewSuccessState());
      } else {
        emit(SendReviewErrorState("Server Error"));
      }
    }).catchError((error) {
      emit(SendReviewErrorState(error));
    });
  }

  int catCount = 0;
  int proCount = 0;
  
  Future<List<SearchSuggestionsModel>> search(String text) async {
    try {
      return await DioHelper.postForm(
        url: EndPoints.searchSuggestions,
        data: FormData.fromMap(
          {'name': text},
        ),
      ).then((response) {
        if (response.statusCode == 200) {
          print('response of search ${response.data}');
          // var type = 'categories'.tr();
          List<SearchSuggestionsModel> suggestions = [];
          catCount = 0;
          proCount = 0;
          (response.data['categories'] as List).forEach((element) {
            catCount++;
            suggestions.add(
              SearchSuggestionsModel.fromMap(
                {
                  'type': 'categories',
                  ...element,
                },
              ),
            );
          });

          // type = 'products'.tr();
          (response.data['products'] as List).forEach((element) {
            proCount++;
            suggestions.add(
              SearchSuggestionsModel.fromMap(
                {
                  'type': 'products',
                  ...element,
                },
              ),
            );
          });
          return suggestions;
        } else {
          return [];
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
