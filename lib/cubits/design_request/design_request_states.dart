
import '../../model/design_request/design_request_model.dart';

abstract class DesignRequestState {}


class DesignRequestInitState extends DesignRequestState {}
class GetDesignRequestLoadingState extends DesignRequestState {}

class GetDesignRequestSuccessState extends DesignRequestState {
DesignRequestModel model;
final int count;
GetDesignRequestSuccessState(this.model,{this.count=0});

}

class GetDesignRequestErrorState extends DesignRequestState {
  final String message;

  GetDesignRequestErrorState(this.message);
}
