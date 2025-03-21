import 'package:dio/dio.dart';
import 'package:wingman/core/constants/router_constants.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/services/auth_session_manager.dart';
import 'package:wingman/core/services/dio_client.dart';
import 'package:wingman/core/services/router_manager.dart';
import 'package:wingman/core/utils/extension_methods/string_extensions.dart';
import 'package:wingman/features/auth/data/datasources/auth_api_data_source.dart';
import 'package:wingman/features/auth/data/models/refresh_request_dto.dart';
import 'package:wingman/features/auth/data/models/token_response_dto.dart';

final class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = sl<AuthSessionManager>().accessToken;
    if (accessToken.isNotNullOrEmpty()) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response!.statusCode == 401 && sl<AuthSessionManager>().userId.isNotNullOrEmpty()) {
      try {
        TokenResponseDto newToken = await sl<AuthApiDataSource>().refresh(
          RefreshRequestDto(
            userId: sl<AuthSessionManager>().userId!,
            refreshToken: sl<AuthSessionManager>().refreshToken!,
          ),
        );
        sl<AuthSessionManager>().saveSession(newToken);
        err.response!.requestOptions.headers['Authorization'] = 'Bearer ${newToken.accessToken}';
        final cloneRequest = await sl<DioClient>().request(err.response!.requestOptions.path);
        return handler.resolve(cloneRequest);
      } catch (e) {
        sl<AuthSessionManager>().clearSession();
        sl<RouterManager>().goNamed(
          '/login',
          pathParameters: {RouterConstants.loginPageShowSessionExpiredWarning: true.toString()},
        );
      }
    }
    super.onError(err, handler);
  }
}
