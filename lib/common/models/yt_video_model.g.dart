// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yt_video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$YTVideoModelImpl _$$YTVideoModelImplFromJson(Map<String, dynamic> json) =>
    _$YTVideoModelImpl(
      kind: json['kind'] as String?,
      etag: json['etag'] as String?,
      id: json['id'] == null
          ? null
          : YTVideoId.fromJson(json['id'] as Map<String, dynamic>),
      snippet: json['snippet'] == null
          ? null
          : YTSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$YTVideoModelImplToJson(_$YTVideoModelImpl instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'id': instance.id,
      'snippet': instance.snippet,
    };

_$YTVideoIdImpl _$$YTVideoIdImplFromJson(Map<String, dynamic> json) =>
    _$YTVideoIdImpl(
      kind: json['kind'] as String?,
      videoId: json['videoId'] as String?,
    );

Map<String, dynamic> _$$YTVideoIdImplToJson(_$YTVideoIdImpl instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'videoId': instance.videoId,
    };

_$YTSnippetImpl _$$YTSnippetImplFromJson(Map<String, dynamic> json) =>
    _$YTSnippetImpl(
      publishedAt: json['publishedAt'] as String?,
      channelId: json['channelId'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      thumbnails: json['thumbnails'] == null
          ? null
          : YTThumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
      channelTitle: json['channelTitle'] as String?,
      liveBroadcastContent: json['liveBroadcastContent'] as String?,
      publishTime: json['publishTime'] as String?,
    );

Map<String, dynamic> _$$YTSnippetImplToJson(_$YTSnippetImpl instance) =>
    <String, dynamic>{
      'publishedAt': instance.publishedAt,
      'channelId': instance.channelId,
      'title': instance.title,
      'description': instance.description,
      'thumbnails': instance.thumbnails,
      'channelTitle': instance.channelTitle,
      'liveBroadcastContent': instance.liveBroadcastContent,
      'publishTime': instance.publishTime,
    };

_$YTThumbnailsImpl _$$YTThumbnailsImplFromJson(Map<String, dynamic> json) =>
    _$YTThumbnailsImpl(
      defaults: json['default'] == null
          ? null
          : YTThumbnail.fromJson(json['default'] as Map<String, dynamic>),
      medium: json['medium'] == null
          ? null
          : YTThumbnail.fromJson(json['medium'] as Map<String, dynamic>),
      high: json['high'] == null
          ? null
          : YTThumbnail.fromJson(json['high'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$YTThumbnailsImplToJson(_$YTThumbnailsImpl instance) =>
    <String, dynamic>{
      'default': instance.defaults,
      'medium': instance.medium,
      'high': instance.high,
    };

_$YTThumbnailImpl _$$YTThumbnailImplFromJson(Map<String, dynamic> json) =>
    _$YTThumbnailImpl(
      url: json['url'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$YTThumbnailImplToJson(_$YTThumbnailImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
