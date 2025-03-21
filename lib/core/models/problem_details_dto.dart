import 'package:json_annotation/json_annotation.dart';

part 'problem_details_dto.g.dart';

@JsonSerializable()
final class ProblemDetailsDto {
  final String type;
  final String title;
  final int status;
  final String detail;
  final String? instance;
  final Map<String, dynamic>? extensions;

  ProblemDetailsDto({
    required this.type,
    required this.title,
    required this.status,
    required this.detail,
    required this.instance,
    required this.extensions,
  });

  factory ProblemDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$ProblemDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemDetailsDtoToJson(this);
}
