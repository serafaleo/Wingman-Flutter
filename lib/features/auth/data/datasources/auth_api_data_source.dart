import 'package:dio/dio.dart';
import 'package:wingman/core/models/api_response_dto.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/services/dio_client.dart';
import 'package:wingman/features/auth/data/constants/auth_api_constants.dart';
import 'package:wingman/features/auth/data/models/login_request_dto.dart';
import 'package:wingman/features/auth/data/models/refresh_request_dto.dart';
import 'package:wingman/features/auth/data/models/signup_request_dto.dart';
import 'package:wingman/features/auth/data/models/token_response_dto.dart';

abstract interface class AuthApiDataSource {
  Future<ApiResponseDto<TokenResponseDto>> login(LoginRequestDto loginDto);
  Future<ApiResponseDto<void>> signUp(SignUpRequestDto signUpDto);
  Future<ApiResponseDto<TokenResponseDto>> refresh(RefreshRequestDto refreshDto);
  Future<ApiResponseDto<void>> logout();
}

final class AuthApiDataSourceImpl implements AuthApiDataSource {
  @override
  Future<ApiResponseDto<TokenResponseDto>> login(LoginRequestDto loginDto) async {
    Response response = await sl<DioClient>().post(
      AuthApiConstants.loginUrl,
      data: loginDto.toJson(),
    );
    return ApiResponseDto.fromJson(
      response.data,
      (json) => TokenResponseDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<void>> signUp(SignUpRequestDto signUpDto) async {
    Response response = await sl<DioClient>().post(
      AuthApiConstants.signUpUrl,
      data: signUpDto.toJson(),
    );
    return ApiResponseDto.fromJson(response.data, (json) {});
  }

  @override
  Future<ApiResponseDto<TokenResponseDto>> refresh(RefreshRequestDto refreshDto) async {
    Response response = await sl<DioClient>().post(
      AuthApiConstants.refreshUrl,
      data: refreshDto.toJson(),
    );
    return ApiResponseDto.fromJson(
      response.data,
      (json) => TokenResponseDto.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponseDto<void>> logout() async {
    Response response = await sl<DioClient>().post(AuthApiConstants.loginUrl);
    return ApiResponseDto.fromJson(response.data, (json) {});
  }
}
