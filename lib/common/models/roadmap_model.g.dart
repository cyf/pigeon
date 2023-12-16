// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoadmapModelImpl _$$RoadmapModelImplFromJson(Map<String, dynamic> json) =>
    _$RoadmapModelImpl(
      title: json['title'] as String?,
      description: json['description'] as String?,
      from:
          json['from'] == null ? null : DateTime.parse(json['from'] as String),
      to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
      background: json['background'] as String?,
      isAllDay: json['isAllDay'] as bool? ?? false,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RoadmapModelImplToJson(_$RoadmapModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'from': instance.from?.toIso8601String(),
      'to': instance.to?.toIso8601String(),
      'background': instance.background,
      'isAllDay': instance.isAllDay,
      'tags': instance.tags,
    };

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) => _$TagImpl(
      title: json['title'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
      'title': instance.title,
      'color': instance.color,
    };
