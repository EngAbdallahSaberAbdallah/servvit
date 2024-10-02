class DisableProductSize {
  int? status;
  String? message;

  DisableProductSize.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}