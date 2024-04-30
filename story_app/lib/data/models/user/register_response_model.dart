class RegisterResponseModel {
    final bool? error;
    final String? message;

    RegisterResponseModel({this.error, this.message});

    factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
        return RegisterResponseModel(
            error: json['error'] as bool?, 
            message: json['message'] as String?,
        );
    }
}
