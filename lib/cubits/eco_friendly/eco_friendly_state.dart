

abstract class EcoFriendlyState {}

class EchoFriendlyInitial extends EcoFriendlyState {}


class GetEchoFriendlyLoadingState extends EcoFriendlyState {}

class GetEchoFriendlySuccessState extends EcoFriendlyState {}

class GetEchoFriendlyErrorState extends EcoFriendlyState {
  final String error;

  GetEchoFriendlyErrorState(this.error);
}