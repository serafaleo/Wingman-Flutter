import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:wingman/core/errors/failure.dart';
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
      TokenResponseDto token = await sl<AuthApiDataSource>().login(
        LoginRequestDto.fromDomain(loginEntity),
      );
      sl<AuthSessionManager>().saveSession(token);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e.response!.data as Failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(SignupRequestEntity signUpEntity) async {
    try {
      await sl<AuthApiDataSource>().signUp(SignUpRequestDto.fromDomain(signUpEntity));
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e.response!.data as Failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await sl<AuthApiDataSource>().logout();
      sl<AuthSessionManager>().clearSession();
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e.response!.data as Failure);
    }
  }
}
