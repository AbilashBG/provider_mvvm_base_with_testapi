class ErrorHandlerModel {
  bool success;
  dynamic message;

  ErrorHandlerModel({
    required this.success,
    required this.message,
  });

  factory ErrorHandlerModel.fromJson(Map<String, dynamic> json) => ErrorHandlerModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };

}
