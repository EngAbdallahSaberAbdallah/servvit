import 'package:echo/cubits/customize_request/customize_request_cubit.dart';
import 'package:echo/model/customize_request/customize_request_model.dart';

abstract class AddToCartCustomizeRequestState {}


class AddToCartCustomizeRequestInitState extends AddToCartCustomizeRequestState {}
class GetAddToCartCustomizeRequestLoadingState extends AddToCartCustomizeRequestState {}

class GetAddToCartCustomizeRequestSuccessState extends AddToCartCustomizeRequestState {

}

class GetAddToCartCustomizeRequestErrorState extends AddToCartCustomizeRequestState {
  final String message;

  GetAddToCartCustomizeRequestErrorState(this.message);
}
