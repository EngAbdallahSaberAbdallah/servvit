import 'package:echo/cubits/customize_request/customize_request_cubit.dart';
import 'package:echo/model/customize_request/customize_request_model.dart';

abstract class RejectDesignedRequestState {}


class RejectDesignedRequestInitState extends RejectDesignedRequestState {}
class RejectDesignedRequestLoadingState extends RejectDesignedRequestState {}

class RejectDesignedRequestSuccessState extends RejectDesignedRequestState {


}

class RejectDesignedRequestErrorState extends RejectDesignedRequestState {
  final String message;

  RejectDesignedRequestErrorState(this.message);
}
