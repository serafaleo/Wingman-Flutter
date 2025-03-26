import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wingman/core/errors/failure.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/features/auth/domain/entities/login_request_entity.dart';
import 'package:wingman/features/auth/domain/entities/signup_request_entity.dart';
import 'package:wingman/features/auth/domain/usecases/login_usecase.dart';
import 'package:wingman/features/auth/domain/usecases/logout_usecase.dart';
import 'package:wingman/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) => emit(AuthLoadingState()));
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthLogoutEvent>(_onAuthLogout);
  }

  FutureOr<void> _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final result = await sl<SignUpUseCase>().call(event.signUpEntity);
    result.fold(
      (failure) => emit(AuthFailureState(failure: failure)),
      (unit) => emit(SignUpSuccessState()),
    );
    return null;
  }

  FutureOr<void> _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final result = await sl<LoginUseCase>().call(event.loginEntity);
    result.fold(
      (failure) => emit(AuthFailureState(failure: failure)),
      (unit) => emit(LoginSuccessState()),
    );
    return null;
  }

  FutureOr<void> _onAuthLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    final result = await sl<LogoutUseCase>().call(unit);
    result.fold(
      (failure) => emit(AuthFailureState(failure: failure)),
      (unit) => emit(LogoutSuccessState()),
    );
    return null;
  }
}
