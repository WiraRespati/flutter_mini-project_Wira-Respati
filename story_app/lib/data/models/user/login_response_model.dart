class LoginResponseModel {
    final bool? error; 
    final String? message;
    final LoginResult? loginResult; 
    LoginResponseModel({this.error, this.message, this.loginResult});

   
    factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
        LoginResult? loginResult;
        if (json.containsKey('loginResult')) {
            loginResult = LoginResult.fromJson(json['loginResult'] as Map<String, dynamic>);
        }
        
        return LoginResponseModel(
            error: json['error'] as bool?,
            message: json['message'] as String?,
            loginResult: loginResult,
        );
    }
}

class LoginResult {
    final String? userId; 
    final String? name; 
    final String? token; 

    LoginResult({this.userId, this.name, this.token});

    factory LoginResult.fromJson(Map<String, dynamic> json) {
        return LoginResult(
            userId: json['userId'] as String?,
            name: json['name'] as String?,
            token: json['token'] as String?,
        );
    }
}