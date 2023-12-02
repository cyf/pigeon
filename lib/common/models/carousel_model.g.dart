// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CarouselModelImpl _$$CarouselModelImplFromJson(Map<String, dynamic> json) =>
    _$CarouselModelImpl(
      id: json['id'] as String?,
      image: json['image'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      text: json['text'] as String?,
      color: json['color'] as String?,
      href: json['href'] as String?,
    );

Map<String, dynamic> _$$CarouselModelImplToJson(_$CarouselModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'order': instance.order,
      'text': instance.text,
      'color': instance.color,
      'href': instance.href,
    };
