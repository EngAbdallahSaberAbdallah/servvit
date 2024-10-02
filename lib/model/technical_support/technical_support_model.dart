class TechnicalSupportModel {
  String? message;


  TechnicalSupportModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

}