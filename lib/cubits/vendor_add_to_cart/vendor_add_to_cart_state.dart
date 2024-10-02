part of 'vendor_add_to_cart_cubit.dart';

@immutable
class VendorAddToCartState {}

class VendorAddToCartInitial extends VendorAddToCartState {}

class VendorSelectedDesign extends VendorAddToCartState {}

class VendorSelectImage extends VendorAddToCartState {}

// upload order to cart
class VendorLoadingAddToCart extends VendorAddToCartState {}

class VendorSuccessAddToCart extends VendorAddToCartState {
  final String message;

  VendorSuccessAddToCart(this.message);
}

class VendorErrorAddToCart extends VendorAddToCartState {
  final String error;

  VendorErrorAddToCart(this.error);
}

class CartCountLoadingState extends VendorAddToCartState {}

class CartCountSuccessState extends VendorAddToCartState {
  final int count;

  CartCountSuccessState({this.count = 0});
}
