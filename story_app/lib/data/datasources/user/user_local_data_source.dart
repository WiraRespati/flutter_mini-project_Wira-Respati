import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSource({required this.sharedPreferences});

  static const tokenKey = 'TOKEN_KEY';
  static const nameKey = 'NAME_KEY';
  static const emailKey = 'EMAIL_KEY';

  Future<String> get token async {
    return sharedPreferences.getString(tokenKey) ?? '';
  }

  Future<String> get name async {
    return sharedPreferences.getString(nameKey) ?? '';
  }

  Future<String> get email async {
    return sharedPreferences.getString(emailKey) ?? '';
  }

  Future<void> setAuth(String token, String name, String email) async {
    await sharedPreferences.setString(tokenKey, token);
    await sharedPreferences.setString(nameKey, name);
    await sharedPreferences.setString(emailKey, email);
    
  }

  Future<void> deleteAuth() async {
    await sharedPreferences.remove(tokenKey);
    await sharedPreferences.remove(nameKey);
    await sharedPreferences.remove(emailKey);
    
  }

  Future<bool> isLoggedIn() async {
    return getToken().then((token) => token.isNotEmpty);
  }

  Future<String> getToken() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return sharedPreferences.getString(tokenKey) ?? '';
    } catch (e) {
     
      return ''; 
    }
  }
}
