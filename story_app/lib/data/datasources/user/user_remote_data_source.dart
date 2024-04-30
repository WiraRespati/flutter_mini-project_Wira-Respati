
import 'package:dio/dio.dart';

import '../../../utils/base_url.dart';
import '../../../utils/constant/validation.dart';
import '../../models/user/login_request_model.dart';
import '../../models/user/login_response_model.dart';
import '../../models/user/register_request_model.dart';
import '../../models/user/register_response_model.dart';

class UserRemoteDataSource {
  static Dio dio = Dio();

  Future<RegisterResponseModel> register(
      RegisterRequestModel registerData) async {
    try {
      final response = await dio.post(
        '${BaseUrl.baseUrl}/register',
        data: registerData.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final registerResponse = RegisterResponseModel.fromJson(response.data);
      return registerResponse;
    } catch (e) {
      Validation.handleError(e);
      return Future.error(e);
    }
    
  }

  Future<LoginResponseModel> login(LoginRequestModel loginData) async {
    try {
      final response = await dio.post(
        '${BaseUrl.baseUrl}/login',
        data: loginData.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      final loginResponse = LoginResponseModel.fromJson(response.data);

      return loginResponse;
    } catch (e) {
     Validation.handleError(e);
     return Future.error(e);
    }
    
  }

  
}
