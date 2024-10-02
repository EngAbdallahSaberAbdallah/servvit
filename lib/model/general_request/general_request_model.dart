class GeneralRequestModel {
  String? message;


  GeneralRequestModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

}