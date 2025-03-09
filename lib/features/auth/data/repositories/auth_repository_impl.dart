import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wingman/core/errors/failure.dart';
import 'package:wingman/core/models/api_response_dto.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/services/auth_session_manager.dart';
import 'package:wingman/features/auth/data/datasources/auth_api_data_source.dart';
import 'package:wingman/features/auth/data/models/login_request_dto.dart';
import 'package:wingman/features/auth/data/models/signup_request_dto.dart';
import 'package:wingman/features/auth/data/models/token_response_dto.dart';
import 'package:wingman/features/auth/domain/entities/login_request_entity.dart';
import 'package:wingman/features/auth/domain/entities/signup_request_entity.dart';
import 'package:wingman/features/auth/domain/repositories/auth_repository.dart';

final class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, Unit>> login(LoginRequestEntity loginEntity) async {
    try {
      ApiResponseDto<TokenResponseDto> apiResponse = await sl<AuthApiDataSource>().login(
        LoginRequestDto.fromDomain(loginEntity),
      );
      if (apiResponse.success) {
        sl<AuthSessionManager>().saveSession(apiResponse.data!);
        return const Right(unit);
      }
      return Left(Failure(apiResponse.message!));
    } catch (e) {
      if (kDebugMode) {
        return Left(Failure(e.toString()));
      } else {
        return Left(Failure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(SignupRequestEntity signUpEntity) async {
    try {
      ApiResponseDto<void> apiResponse = await sl<AuthApiDataSource>().signUp(
        SignUpRequestDto.fromDomain(signUpEntity),
      );
      if (apiResponse.success) {
        return const Right(unit);
      }
      return Left(Failure(apiResponse.message!));
    } catch (e) {
      if (kDebugMode) {
        return Left(Failure(e.toString()));
      } else {
        return Left(Failure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      ApiResponseDto<void> apiResponse = await sl<AuthApiDataSource>().logout();
      if (apiResponse.success) {
        sl<AuthSessionManager>().clearSession();
        return const Right(unit);
      }
      return Left(Failure(apiResponse.message!));
    } catch (e) {
      if (kDebugMode) {
        return Left(Failure(e.toString()));
      } else {
        return Left(Failure());
      }
    }
  }
}
