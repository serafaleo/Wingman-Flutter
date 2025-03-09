import 'package:json_annotation/json_annotation.dart';

part 'token_response_dto.g.dart';

@JsonSerializable()
final class TokenResponseDto {
  final String userId;
  final String accessToken;
  final String refreshToken;

  TokenResponseDto({required this.userId, required this.accessToken, required this.refreshToken});

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) => _$TokenResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseDtoToJson(this);
}
