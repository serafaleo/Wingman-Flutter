// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponseDto _$TokenResponseDtoFromJson(Map<String, dynamic> json) =>
    TokenResponseDto(
      userId: json['userId'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$TokenResponseDtoToJson(TokenResponseDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
