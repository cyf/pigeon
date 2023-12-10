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
    );

Map<String, dynamic> _$$FeedbackModelImplToJson(_$FeedbackModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'files': instance.files,
    };

_$FeedbackFileModelImpl _$$FeedbackFileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FeedbackFileModelImpl(
      id: json['id'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      size: json['size'] as int?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$$FeedbackFileModelImplToJson(
        _$FeedbackFileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'type': instance.type,
      'size': instance.size,
      'text': instance.text,
    };
