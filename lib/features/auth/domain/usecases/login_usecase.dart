import 'package:fpdart/fpdart.dart';
import 'package:wingman/core/errors/failure.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/usecase/usecase.dart';
import 'package:wingman/features/auth/domain/entities/login_request_entity.dart';
import 'package:wingman/features/auth/domain/repositories/auth_repository.dart';

final class LoginUseCase implements UseCase<Unit, LoginRequestEntity> {
  @override
  Future<Either<Failure, Unit>> call(LoginRequestEntity loginEntity) async {
    return await sl<AuthRepository>().login(loginEntity);
  }
}
