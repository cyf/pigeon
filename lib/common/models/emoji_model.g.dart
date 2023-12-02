// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmojiModelImpl _$$EmojiModelImplFromJson(Map<String, dynamic> json) =>
    _$EmojiModelImpl(
      id: json['id'] as String?,
      image: json['image'] as String? ?? '',
      text: json['text'] as String?,
    );

Map<String, dynamic> _$$EmojiModelImplToJson(_$EmojiModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'text': instance.text,
    };
