import 'package:echo/cubits/customize_request/customize_request_cubit.dart';
import 'package:echo/model/customize_request/customize_request_model.dart';

abstract class CustomizeRequestState {}


class CustomizeRequestInitState extends CustomizeRequestState {}
class GetCustomizeRequestLoadingState extends CustomizeRequestState {}

class GetCustomizeRequestSuccessState extends CustomizeRequestState {
CustomizeRequestModel model;
GetCustomizeRequestSuccessState(this.model);

}

class GetCustomizeRequestErrorState extends CustomizeRequestState {
  final String message;

  GetCustomizeRequestErrorState(this.message);
}
