import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wingman/core/constants/secure_storage_constants.dart';
import 'package:wingman/core/service_locator.dart';
import 'package:wingman/core/utils/extension_methods/string_extensions.dart';
import 'package:wingman/features/auth/data/models/token_response_dto.dart';

abstract interface class AuthSessionManager {
  String? get userName;
  String? get userId;
  String? get accessToken;
  String? get refreshToken;
  Future<void> saveSession(TokenResponseDto tokenDto);
  Future<void> clearSession();
  Future<void> tryRestoreSession();
}

final class AuthSessionManagerImpl implements AuthSessionManager {
  TokenResponseDto? _tokenDto;

  @override
  String? get userName => _tokenDto?.userName;
  @override
  String? get userId => _tokenDto?.userId;
  @override
  String? get accessToken => _tokenDto?.accessToken;
  @override
  String? get refreshToken => _tokenDto?.refreshToken;

  @override
  Future<void> saveSession(TokenResponseDto tokenDto) async {
    _tokenDto = tokenDto;
    await sl<FlutterSecureStorage>().write(
      key: SecureStorageConstants.authSession,
      value: jsonEncode(tokenDto.toJson()),
    );
  }

  @override
  Future<void> clearSession() async {
    _tokenDto = null;
    await sl<FlutterSecureStorage>().delete(key: SecureStorageConstants.authSession);
  }

  @override
  Future<void> tryRestoreSession() async {
    String? tokenDtoJsonString = await sl<FlutterSecureStorage>().read(
      key: SecureStorageConstants.authSession,
    );
    if (tokenDtoJsonString.isNotNullOrEmpty()) {
      _tokenDto = TokenResponseDto.fromJson(jsonDecode(tokenDtoJsonString!));
    }
  }
}
