// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequestDto _$SignUpRequestDtoFromJson(Map<String, dynamic> json) =>
    SignUpRequestDto(
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['passwordConfirmation'] as String,
    );

Map<String, dynamic> _$SignUpRequestDtoToJson(SignUpRequestDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'passwordConfirmation': instance.passwordConfirmation,
    };
