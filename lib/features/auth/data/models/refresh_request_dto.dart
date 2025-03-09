import 'package:json_annotation/json_annotation.dart';

part 'refresh_request_dto.g.dart';

@JsonSerializable()
final class RefreshRequestDto {
  final String userId;
  final String refreshToken;

  RefreshRequestDto({required this.userId, required this.refreshToken});

  factory RefreshRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshRequestDtoToJson(this);
}
