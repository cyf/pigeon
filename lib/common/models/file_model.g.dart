// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FileModelImpl _$$FileModelImplFromJson(Map<String, dynamic> json) =>
    _$FileModelImpl(
      url: json['url'] as String?,
      pathname: json['pathname'] as String?,
      contentType: json['contentType'] as String?,
      fileSize: json['fileSize'] as int?,
    );

Map<String, dynamic> _$$FileModelImplToJson(_$FileModelImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'pathname': instance.pathname,
      'contentType': instance.contentType,
      'fileSize': instance.fileSize,
    };
