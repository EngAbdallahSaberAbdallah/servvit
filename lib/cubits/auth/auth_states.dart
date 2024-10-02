abstract class AuthStates {}

class AuthInitState extends AuthStates {}

class SuccessPickImage extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {
  final String message;

  RegisterSuccessState(this.message);
}

class RegisterErrorState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final String message;

  LoginSuccessState(this.message);
}

class LoginErrorState extends AuthStates {}

class SendOtpLoadingState extends AuthStates {}

class SendOtpSuccessState extends AuthStates {
  final String message;

  SendOtpSuccessState(this.message);
}

class SendOtpErrorState extends AuthStates {}

class LogoutLoadingState extends AuthStates {}

class LogoutSuccessState extends AuthStates {
  final String message;

  LogoutSuccessState(this.message);
}

class LogoutErrorState extends AuthStates {}

class GetGovernmentsLoadingState extends AuthStates {}

class GetGovernmentsSuccessState extends AuthStates {}

class GetGovernmentsErrorState extends AuthStates {}

class GetBusinessTypesLoadingState extends AuthStates {}

class GetBusinessTypesSuccessState extends AuthStates {}

class GetBusinessTypesErrorState extends AuthStates {}

class GetProfileDataLoadingState extends AuthStates {}

class GetProfileDataSuccessState extends AuthStates {}

class GetProfileDataErrorState extends AuthStates {}

class UpdateProfileLoadingState extends AuthStates {}

class UpdateProfileSuccessState extends AuthStates {
  final String message;

  UpdateProfileSuccessState(this.message);
}

class UpdateProfileErrorState extends AuthStates {}

class SendFcmTokenLoadingState extends AuthStates {}

class SendFcmTokenSuccessState extends AuthStates {}

class SendFcmTokenErrorState extends AuthStates {}
