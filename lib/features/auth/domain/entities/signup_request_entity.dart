import 'package:wingman/core/utils/extension_methods/string_extensions.dart';

class SignupRequestEntity {
  final String email;
  final String password;
  final String passwordConfirmation;

  SignupRequestEntity({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });
}

final class SignUpRequestEntityValidator {
  static String? validateEmail(String? email) {
    if (email.isNullOrEmpty()) {
      return 'Email is required';
    }
    if (email!.length > 100) {
      return 'Email must contains up to 100 characters';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password.isNullOrEmpty()) {
      return 'Password is required';
    }
    if (password!.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]+').hasMatch(password)) {
      return 'Password must have at least one upper case letter';
    }
    if (!RegExp(r'[a-z]+').hasMatch(password)) {
      return 'Password must have at least one lower case letter';
    }
    if (!RegExp(r'[0-9]+').hasMatch(password)) {
      return 'Password must have at least one digit';
    }
    if (!RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) {
      return 'Password must have at least one special character';
    }
    return null;
  }

  static String? validatePasswordConfirm(String? passwordConfirmation, String? password) {
    if (passwordConfirmation.isNullOrEmpty()) {
      return 'You must confirm your password';
    }
    if (password.isNotNullOrEmpty() && passwordConfirmation != password) {
      return 'Passwords must be equal';
    }
    return null;
  }
}
