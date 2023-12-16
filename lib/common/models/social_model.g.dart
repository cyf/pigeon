// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SocialModelImpl _$$SocialModelImplFromJson(Map<String, dynamic> json) =>
    _$SocialModelImpl(
      title: json['title'] as String?,
      subtitles: (json['subtitles'] as List<dynamic>?)
          ?.map((e) => SubTitle.fromJson(e as Map<String, dynamic>))
          .toList(),
      tips: (json['tips'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      descriptions: (json['descriptions'] as List<dynamic>?)
          ?.map((e) => Description.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SocialModelImplToJson(_$SocialModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitles': instance.subtitles,
      'tips': instance.tips,
      'descriptions': instance.descriptions,
    };

_$SubTitleImpl _$$SubTitleImplFromJson(Map<String, dynamic> json) =>
    _$SubTitleImpl(
      title: json['title'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$SubTitleImplToJson(_$SubTitleImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'color': instance.color,
    };

_$DescriptionImpl _$$DescriptionImplFromJson(Map<String, dynamic> json) =>
    _$DescriptionImpl(
      name: json['name'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DescriptionImplToJson(_$DescriptionImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'links': instance.links,
    };

_$LinkImpl _$$LinkImplFromJson(Map<String, dynamic> json) => _$LinkImpl(
      type: $enumDecodeNullable(_$LinkTypeEnumMap, json['type']),
      text: json['text'] as String?,
      href: json['href'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$LinkImplToJson(_$LinkImpl instance) =>
    <String, dynamic>{
      'type': _$LinkTypeEnumMap[instance.type],
      'text': instance.text,
      'href': instance.href,
      'color': instance.color,
    };

const _$LinkTypeEnumMap = {
  LinkType.link: 'link',
  LinkType.text: 'text',
};
