// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshRequestDto _$RefreshRequestDtoFromJson(Map<String, dynamic> json) =>
    RefreshRequestDto(
      userId: json['userId'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$RefreshRequestDtoToJson(RefreshRequestDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'refreshToken': instance.refreshToken,
    };
