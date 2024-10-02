import 'package:echo/cubits/customize_request/customize_request_cubit.dart';
import 'package:echo/model/customize_request/customize_request_model.dart';

abstract class AddToCartDesignedRequestState {}


class AddToCartDesignedRequestInitState extends AddToCartDesignedRequestState {}
class GetAddToCartDesignedRequestLoadingState extends AddToCartDesignedRequestState {}

class GetAddToCartDesignedRequestSuccessState extends AddToCartDesignedRequestState {

}

class GetAddToCartDesignedRequestErrorState extends AddToCartDesignedRequestState {
  final String message;

  GetAddToCartDesignedRequestErrorState(this.message);
}
