import 'package:fpdart/fpdart.dart';
import 'package:wingman/core/errors/failure.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/usecase/usecase.dart';
import 'package:wingman/features/auth/domain/repositories/auth_repository.dart';

final class LogoutUseCase implements UseCase<Unit, Unit> {
  @override
  Future<Either<Failure, Unit>> call(Unit params) async {
    return await sl<AuthRepository>().logout();
  }
}
