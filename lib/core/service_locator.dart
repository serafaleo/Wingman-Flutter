import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:wingman/core/services/auth_session_manager.dart';
import 'package:wingman/core/services/dio_client.dart';
import 'package:wingman/core/services/router_manager.dart';
import 'package:wingman/features/auth/data/datasources/auth_api_data_source.dart';
import 'package:wingman/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:wingman/features/auth/domain/repositories/auth_repository.dart';
import 'package:wingman/features/auth/domain/usecases/login_usecase.dart';
import 'package:wingman/features/auth/domain/usecases/logout_usecase.dart';
import 'package:wingman/features/auth/domain/usecases/signup_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // MUST be before AuthSessionManager
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  sl.registerLazySingleton<AuthSessionManager>(() => AuthSessionManagerImpl());
  sl.registerLazySingleton<RouterManager>(() => RouterManager());

  _setupAuth();
}

void _setupAuth() {
  // Data Sources
  sl.registerLazySingleton<AuthApiDataSource>(() => AuthApiDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // UseCases
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase());
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase());
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase());
}
