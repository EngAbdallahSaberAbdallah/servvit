

abstract class AllServicesState {}

class AllServicesInitial extends AllServicesState {}


class GetAllServicesLoadingState extends AllServicesState {}

class GetAllServicesSuccessState extends AllServicesState {}

class GetAllServicesErrorState extends AllServicesState {
  final String error;

  GetAllServicesErrorState(this.error);
}
