// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmojiParamImpl _$$EmojiParamImplFromJson(Map<String, dynamic> json) =>
    _$EmojiParamImpl(
      image: json['image'] as String?,
      type: json['type'] as String?,
      size: (json['size'] as num?)?.toInt(),
      text: json['text'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$EmojiParamImplToJson(_$EmojiParamImpl instance) =>
    <String, dynamic>{
      'image': instance.image,
      'type': instance.type,
      'size': instance.size,
      'text': instance.text,
      'color': instance.color,
    };
