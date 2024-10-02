

abstract class AllCustomersState {}

class AllCustomersInitial extends AllCustomersState {}



class GetAllCustomersLoadingState extends AllCustomersState {}

class GetAllCustomersSuccessState extends AllCustomersState {}

class GetAllCustomersErrorState extends AllCustomersState {
  final String error;

  GetAllCustomersErrorState(this.error);
}

