class CustomProductModel {
  String? message;


  CustomProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

}