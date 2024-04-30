

import 'package:story_app/data/models/user/login_request_model.dart';
import 'package:story_app/data/models/user/login_response_model.dart';

import '../datasources/user/user_local_data_source.dart';
import '../datasources/user/user_remote_data_source.dart';
import '../models/user/register_request_model.dart';
import '../models/user/user_model.dart';

class UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  UserRepository(this._userRemoteDataSource, this._userLocalDataSource);

  Future<void> register(RegisterRequestModel registerData) async {
    await _userRemoteDataSource.register(registerData);
  }

  Future<LoginResponseModel> login(LoginRequestModel loginData) async {
    final loginResponse = await _userRemoteDataSource.login(loginData);
    final token = loginResponse.loginResult!.token;
    final name = loginResponse.loginResult!.name;
    final email = loginData.email;
     _userLocalDataSource.setAuth(token!, name!, email);
    return loginResponse;
  }

  Future<void> deleteAuth() async {
    _userLocalDataSource.deleteAuth();
  }

  Future<bool> isLogin() async {
    return _userLocalDataSource.isLoggedIn();
  }
  Future<UserModel> getUser() async {
    final name = await _userLocalDataSource.name;
    final email = await _userLocalDataSource.email;
    return UserModel(name, email);
  }

}
