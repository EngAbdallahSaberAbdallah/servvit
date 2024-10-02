import 'package:echo/cubits/customize_request/customize_request_cubit.dart';
import 'package:echo/model/customize_request/customize_request_model.dart';

abstract class RejectCustomizeRequestState {}


class RejectCustomizeRequestInitState extends RejectCustomizeRequestState {}
class RejectCustomizeRequestLoadingState extends RejectCustomizeRequestState {}

class RejectCustomizeRequestSuccessState extends RejectCustomizeRequestState {


}

class RejectCustomizeRequestErrorState extends RejectCustomizeRequestState {
  final String message;

  RejectCustomizeRequestErrorState(this.message);
}
