part of 'payment_method_cubit.dart';

@immutable
sealed class PaymentMethodState {}

final class PaymentMethodInitial extends PaymentMethodState {}

final class VendorSelectImage extends PaymentMethodState {}

/// get all governorates

class GovernorateLoadingState extends PaymentMethodState {}

class GovernorateSuccessState extends PaymentMethodState {}

class GovernorateErrorState extends PaymentMethodState {
  final String error;
  GovernorateErrorState(this.error);
}

//! shipping cost
class GetShippingCostLoadingState extends PaymentMethodState {}

class GetShippingCostSuccessState extends PaymentMethodState {}

class GetShippingCostFailureState extends PaymentMethodState {
  final String errorMessage;
  GetShippingCostFailureState(this.errorMessage);
}

class PayLoadingState extends PaymentMethodState {}

class PayWithPaymobLoadingState extends PaymentMethodState {}

class PaySuccessState extends PaymentMethodState {
  final String message;
  final int orderNumber;
  PaySuccessState(this.message, this.orderNumber);
}

class PaymobSuccessState extends PaymentMethodState {
  final String token;
  PaymobSuccessState(
    this.token,
  );
}

class PaymentCardSuccess extends PaymentMethodState {
  final bool success;
  PaymentCardSuccess(this.success);
}

class PayFailureState extends PaymentMethodState {
  final String errorMessage;
  PayFailureState(this.errorMessage);
}

class PaymentProgressValue extends PaymentMethodState {
  final int progress;
  PaymentProgressValue(this.progress);
}

class PaymentLoaded extends PaymentMethodState {}
class addOrderSuccessState extends PaymentMethodState {}
class addOrderErrorState extends PaymentMethodState {}
