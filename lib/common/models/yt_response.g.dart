// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yt_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YTResponse<T> _$YTResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    YTResponse<T>(
      kind: json['kind'] as String?,
      etag: json['etag'] as String?,
      prevPageToken: json['prevPageToken'] as String?,
      nextPageToken: json['nextPageToken'] as String?,
      regionCode: json['regionCode'] as String?,
      pageInfo: json['pageInfo'] == null
          ? null
          : YTPageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      items: _$nullableGenericFromJson(json['items'], fromJsonT),
    );

Map<String, dynamic> _$YTResponseToJson<T>(
  YTResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'kind': instance.kind,
      'etag': instance.etag,
      'prevPageToken': instance.prevPageToken,
      'nextPageToken': instance.nextPageToken,
      'regionCode': instance.regionCode,
      'pageInfo': instance.pageInfo?.toJson(),
      'items': _$nullableGenericToJson(instance.items, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

YTPageInfo _$YTPageInfoFromJson(Map<String, dynamic> json) => YTPageInfo(
      totalResults: (json['totalResults'] as num?)?.toInt(),
      resultsPerPage: (json['resultsPerPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$YTPageInfoToJson(YTPageInfo instance) =>
    <String, dynamic>{
      'totalResults': instance.totalResults,
      'resultsPerPage': instance.resultsPerPage,
    };
