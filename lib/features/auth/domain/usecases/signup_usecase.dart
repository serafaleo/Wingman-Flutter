import 'package:fpdart/fpdart.dart';
import 'package:wingman/core/errors/failure.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/usecase/usecase.dart';
import 'package:wingman/features/auth/domain/entities/login_request_entity.dart';
import 'package:wingman/features/auth/domain/entities/signup_request_entity.dart';
import 'package:wingman/features/auth/domain/repositories/auth_repository.dart';

final class SignUpUseCase implements UseCase<Unit, SignupRequestEntity> {
  @override
  Future<Either<Failure, Unit>> call(signUpEntity) async {
    final signUpResult = await sl<AuthRepository>().signUp(signUpEntity);
    return await signUpResult.fold((failure) async => Left(failure), (unit) async {
      return await sl<AuthRepository>().login(
        LoginRequestEntity(email: signUpEntity.email, password: signUpEntity.password),
      );
    });
  }
}
