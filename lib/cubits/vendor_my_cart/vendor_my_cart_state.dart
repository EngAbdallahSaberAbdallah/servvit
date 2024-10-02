part of 'vendor_my_cart_cubit.dart';

@immutable
class VendorMyCartState {}

class VendorMyCartInitial extends VendorMyCartState {}

// get vendor my cart
final class VendorMyCartLoading extends VendorMyCartState {}

final class VendorMyCartSuccess extends VendorMyCartState {}

final class VendorMyCartError extends VendorMyCartState {
  final String error;
  VendorMyCartError(this.error);
}

// delete from cart
final class VendorMyCartDeleteLoading extends VendorMyCartState {}

final class VendorMyCartDeleteSuccess extends VendorMyCartState {
  final String message;
  VendorMyCartDeleteSuccess(this.message);
}

final class VendorMyCartDeleteError extends VendorMyCartState {
  final String error;
  VendorMyCartDeleteError(this.error);
}
