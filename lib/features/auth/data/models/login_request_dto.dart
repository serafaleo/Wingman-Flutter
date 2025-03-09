import 'package:json_annotation/json_annotation.dart';
import 'package:wingman/features/auth/domain/entities/login_request_entity.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
final class LoginRequestDto extends LoginRequestEntity {
  LoginRequestDto({required super.email, required super.password});

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) => _$LoginRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);

  factory LoginRequestDto.fromDomain(LoginRequestEntity loginEntity) {
    return LoginRequestDto(email: loginEntity.email, password: loginEntity.password);
  }

  LoginRequestEntity toDomain() {
    return LoginRequestEntity(email: email, password: password);
  }
}
