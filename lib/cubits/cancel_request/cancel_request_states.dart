import 'package:echo/cubits/customize_request/customize_request_cubit.dart';
import 'package:echo/model/customize_request/customize_request_model.dart';

abstract class CancelRequestState {}


class CancelRequestInitState extends CancelRequestState {}
class CancelRequestLoadingState extends CancelRequestState {}

class CancelRequestSuccessState extends CancelRequestState {


}

class CancelRequestErrorState extends CancelRequestState {
  final String message;

  CancelRequestErrorState(this.message);
}
