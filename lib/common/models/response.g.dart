// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HpResponse<T> _$HpResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    HpResponse<T>(
      msg: json['msg'] as String?,
      code: json['code'] as int?,
      timestamp: json['timestamp'] as int?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$HpResponseToJson<T>(
  HpResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'timestamp': instance.timestamp,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
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
