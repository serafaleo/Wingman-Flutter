part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpEvent extends AuthEvent {
  final SignupRequestEntity signUpEntity;

  AuthSignUpEvent({required this.signUpEntity});
}

final class AuthLoginEvent extends AuthEvent {
  final LoginRequestEntity loginEntity;

  AuthLoginEvent({required this.loginEntity});
}

final class AuthLogoutEvent extends AuthEvent {}
