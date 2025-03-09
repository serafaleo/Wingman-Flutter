part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LogoutSuccessState extends AuthState {}

final class AuthFailureState extends AuthState {
  final Failure failure;

  const AuthFailureState({required this.failure});
}
