part of 'vendor_profile_cubit.dart';

@immutable
class VendorProfileState {}

class VendorProfileInitial extends VendorProfileState {}

// chech if the user is in full screen or not
class VendorProfileFullScreen extends VendorProfileState {}

class VendorProfileNotFullScreen extends VendorProfileState {}

// get all notifications
class VendorProfileNotificationLoading extends VendorProfileState {}

class VendorProfileNotificationSuccess extends VendorProfileState {
  final int count;
  VendorProfileNotificationSuccess({this.count=0});
}

class VendorProfileNotificationError extends VendorProfileState {
  VendorProfileNotificationError(this.error);
  final String error;
}

// get all accepted orders
class VendorProfileAcceptedOrdersLoading extends VendorProfileState {}

class VendorProfileAcceptedOrdersSuccess extends VendorProfileState {}

class VendorProfileAcceptedOrdersError extends VendorProfileState {
  VendorProfileAcceptedOrdersError(this.error);
  final String error;
}

// get all rejected orders
class VendorProfileRejectedOrdersLoading extends VendorProfileState {}

class VendorProfileRejectedOrdersSuccess extends VendorProfileState {}

class VendorProfileRejectedOrdersError extends VendorProfileState {
  VendorProfileRejectedOrdersError(this.error);
  final String error;
}

// get all pending orders
class VendorProfilePendingOrdersLoading extends VendorProfileState {}

class VendorProfilePendingOrdersSuccess extends VendorProfileState {}

class VendorProfilePendingOrdersError extends VendorProfileState {
  VendorProfilePendingOrdersError(this.error);
  final String error;
}

// all order get
class VendorProfileAllOrdersLoading extends VendorProfileState {}

class VendorProfileAllOrdersSuccess extends VendorProfileState {
  final int count;
  VendorProfileAllOrdersSuccess({this.count =0});
}

class VendorProfileAllOrdersError extends VendorProfileState {
  VendorProfileAllOrdersError(this.error);
  final String error;
}
