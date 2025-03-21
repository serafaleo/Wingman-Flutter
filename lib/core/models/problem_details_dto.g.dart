// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProblemDetailsDto _$ProblemDetailsDtoFromJson(Map<String, dynamic> json) =>
    ProblemDetailsDto(
      type: json['type'] as String,
      title: json['title'] as String,
      status: (json['status'] as num).toInt(),
      detail: json['detail'] as String,
      instance: json['instance'] as String?,
      extensions: json['extensions'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ProblemDetailsDtoToJson(ProblemDetailsDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'status': instance.status,
      'detail': instance.detail,
      'instance': instance.instance,
      'extensions': instance.extensions,
    };
