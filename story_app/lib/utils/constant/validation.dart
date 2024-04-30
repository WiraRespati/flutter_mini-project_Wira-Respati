import 'package:dio/dio.dart';

class Validation {
  static String? validateName(String name) {
    if (name.isEmpty) {
      return "Name cannot be empty";
    }
    return null;
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return "Email cannot be empty";
    } else if (!email.contains('@')) {
      return "Invalid email format, should have @";
    } else if (!email.contains('.')) {
      return "Invalid email format (example.com)";
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Password cannot be empty";
    } else if (password.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  static void handleError(e) {
    if (e is DioError) {
      final response = e.response;
      if (response != null) {
        throw Exception('Failed: ${response.data}');
      } else {
        throw Exception('Failed due to network error: ${e.message}');
      }
    } else {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

}
