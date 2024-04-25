// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedbackModelImpl _$$FeedbackModelImplFromJson(Map<String, dynamic> json) =>
    _$FeedbackModelImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => FeedbackFileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createBy: json['create_by'] as String?,
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      updateBy: json['update_by'] as String?,
      updateDate: json['update_date'] == null
          ? null
          : DateTime.parse(json['update_date'] as String),
    );

Map<String, dynamic> _$$FeedbackModelImplToJson(_$FeedbackModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'files': instance.files,
      'create_by': instance.createBy,
      'create_date': instance.createDate?.toIso8601String(),
      'update_by': instance.updateBy,
      'update_date': instance.updateDate?.toIso8601String(),
    };

_$FeedbackFileModelImpl _$$FeedbackFileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FeedbackFileModelImpl(
      id: json['id'] as String?,
      feedbackId: json['feedback_id'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      size: (json['size'] as num?)?.toInt(),
      title: json['title'] as String?,
      createBy: json['create_by'] as String?,
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      updateBy: json['update_by'] as String?,
      updateDate: json['update_date'] == null
          ? null
          : DateTime.parse(json['update_date'] as String),
    );

Map<String, dynamic> _$$FeedbackFileModelImplToJson(
        _$FeedbackFileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'feedback_id': instance.feedbackId,
      'url': instance.url,
      'type': instance.type,
      'size': instance.size,
      'title': instance.title,
      'create_by': instance.createBy,
      'create_date': instance.createDate?.toIso8601String(),
      'update_by': instance.updateBy,
      'update_date': instance.updateDate?.toIso8601String(),
    };
