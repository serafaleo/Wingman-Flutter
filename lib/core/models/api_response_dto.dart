import 'package:json_annotation/json_annotation.dart';

part 'api_response_dto.g.dart';

@JsonSerializable(genericArgumentFactories: true)
final class ApiResponseDto<T> {
  final int statusCode;
  final bool success;
  final String? message;
  final T? data;
  final List<String>? errors;

  ApiResponseDto({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory ApiResponseDto.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ApiResponseDtoFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) => _$ApiResponseDtoToJson(this, toJsonT);
}
