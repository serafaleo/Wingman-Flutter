part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String passwordConfirmation;

  AuthSignUpEvent({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });
}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});
}

final class AuthLogoutEvent extends AuthEvent {}
