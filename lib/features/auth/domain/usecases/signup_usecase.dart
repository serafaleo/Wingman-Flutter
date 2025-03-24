import 'package:fpdart/fpdart.dart';
import 'package:wingman/core/errors/failure.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/usecase/usecase.dart';
import 'package:wingman/features/auth/domain/entities/signup_request_entity.dart';
import 'package:wingman/features/auth/domain/repositories/auth_repository.dart';

final class SignUpUseCase implements UseCase<Unit, SignupRequestEntity> {
  @override
  Future<Either<Failure, Unit>> call(signUpEntity) async {
    return await sl<AuthRepository>().signUp(signUpEntity);
  }
}
