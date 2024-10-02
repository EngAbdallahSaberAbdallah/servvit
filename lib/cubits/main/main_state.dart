import 'package:echo/model/reviews/reviews_model.dart';

import '../../model/countries/country_model.dart';

abstract class MainState {}

class MainInitial extends MainState {}

class GetAllReviewsLoadingState extends MainState {}

class GetAllReviewsSuccessState extends MainState {
  ReviewsModel model;
  GetAllReviewsSuccessState(this.model);
}

class SendRequestToTechnicalSupportLoadingState extends MainState {}

class SendRequestToTechnicalSupportErrorState extends MainState {
  String error;
  SendRequestToTechnicalSupportErrorState(this.error);
}

class SendRequestToTechnicalSupportSuccessState extends MainState {}

class SendReviewLoadingState extends MainState {}

class SendReviewErrorState extends MainState {
  String error;
  SendReviewErrorState(this.error);
}

class SendReviewSuccessState extends MainState {}

class GetAllReviewsErrorState extends MainState {
  final String error;

  GetAllReviewsErrorState(this.error);
}

class GetAllCountriesLoadingState extends MainState {}

class GetAllCountriesSuccessState extends MainState {
  CountryModel model;
  GetAllCountriesSuccessState(this.model);
}

class GetAllCountriesErrorState extends MainState {
  final String error;

  GetAllCountriesErrorState(this.error);
}

class SearchTextLoadingState extends MainState {}

class SearchTextSuccessState extends MainState {}

class SearchTextFailureState extends MainState {
  final String errorMessage;
  SearchTextFailureState(this.errorMessage);
}
