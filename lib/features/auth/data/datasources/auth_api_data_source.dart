import 'package:dio/dio.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/services/dio_client.dart';
import 'package:wingman/features/auth/data/constants/auth_api_constants.dart';
import 'package:wingman/features/auth/data/models/login_request_dto.dart';
import 'package:wingman/features/auth/data/models/refresh_request_dto.dart';
import 'package:wingman/features/auth/data/models/signup_request_dto.dart';
import 'package:wingman/features/auth/data/models/token_response_dto.dart';

abstract interface class AuthApiDataSource {
  Future<void> signUp(SignUpRequestDto signUpDto);
  Future<TokenResponseDto> login(LoginRequestDto loginDto);
  Future<TokenResponseDto> refresh(RefreshRequestDto refreshDto);
  Future<void> logout();
}

final class AuthApiDataSourceImpl implements AuthApiDataSource {
  @override
  Future<TokenResponseDto> login(LoginRequestDto loginDto) async {
    Response response = await sl<DioClient>().post(
      AuthApiConstants.loginUrl,
      data: loginDto.toJson(),
    );
    return TokenResponseDto.fromJson(response.data);
  }

  @override
  Future<void> signUp(SignUpRequestDto signUpDto) async {
    await sl<DioClient>().post(AuthApiConstants.signUpUrl, data: signUpDto.toJson());
    return;
  }

  @override
  Future<TokenResponseDto> refresh(RefreshRequestDto refreshDto) async {
    Response response = await sl<DioClient>().post(
      AuthApiConstants.refreshUrl,
      data: refreshDto.toJson(),
    );
    return TokenResponseDto.fromJson(response.data);
  }

  @override
  Future<void> logout() async {
    await sl<DioClient>().post(AuthApiConstants.logouUrl);
    return;
  }
}
