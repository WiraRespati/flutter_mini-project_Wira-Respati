class UploadStoryResponseModel {
  final bool? error;
  final String? message;

  UploadStoryResponseModel({
    this.error,
    this.message,
  });

  factory UploadStoryResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadStoryResponseModel(
      error: json['error'] ?? true,
      message: json['message'] ?? 'Unknown error occurred',
    );
  }
}
