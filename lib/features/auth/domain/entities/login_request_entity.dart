import 'package:wingman/core/utils/extension_methods/string_extensions.dart';

class LoginRequestEntity {
  final String email;
  final String password;

  LoginRequestEntity({required this.email, required this.password});
}

final class LoginRequestEntityValidator {
  static String? validateEmail(String? email) {
    if (email.isNullOrEmpty()) {
      return 'Email is required';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password.isNullOrEmpty()) {
      return 'Password is required';
    }
    return null;
  }
}
