// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pager.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pager<T> _$PagerFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Pager<T>(
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      items: _$nullableGenericFromJson(json['items'], fromJsonT),
    );

Map<String, dynamic> _$PagerToJson<T>(
  Pager<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
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

PageInfo _$PageInfoFromJson(Map<String, dynamic> json) => PageInfo(
      total: (json['total'] as num?)?.toInt(),
      pages: (json['pages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PageInfoToJson(PageInfo instance) => <String, dynamic>{
      'total': instance.total,
      'pages': instance.pages,
    };
