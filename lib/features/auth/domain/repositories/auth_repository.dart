import 'package:fpdart/fpdart.dart';
import 'package:wingman/core/errors/failure.dart';
import 'package:wingman/features/auth/domain/entities/login_request_entity.dart';
import 'package:wingman/features/auth/domain/entities/signup_request_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Unit>> login(LoginRequestEntity loginEntity);
  Future<Either<Failure, Unit>> signUp(SignupRequestEntity signUpEntity);
  Future<Either<Failure, Unit>> logout();
}
