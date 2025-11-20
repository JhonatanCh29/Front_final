class ErrorResponseModel {
  final String timestamp;
  final String message;
  final int status;
  final Map<String, String>? errors;

  ErrorResponseModel({
    required this.timestamp,
    required this.message,
    required this.status,
    this.errors,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      timestamp: json['timestamp'] as String,
      message: json['message'] as String,
      status: json['status'] as int,
      errors: json['errors'] != null
          ? Map<String, String>.from(json['errors'] as Map)
          : null,
    );
  }
}
