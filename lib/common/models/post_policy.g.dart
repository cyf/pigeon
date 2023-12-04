// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostPolicyImpl _$$PostPolicyImplFromJson(Map<String, dynamic> json) =>
    _$PostPolicyImpl(
      policy: json['policy'] as String?,
      signature: json['signature'] as String?,
      dir: json['dir'] as String?,
      expire: json['expire'] as int?,
      accessId: json['accessId'] as String?,
      host: json['host'] as String?,
    );

Map<String, dynamic> _$$PostPolicyImplToJson(_$PostPolicyImpl instance) =>
    <String, dynamic>{
      'policy': instance.policy,
      'signature': instance.signature,
      'dir': instance.dir,
      'expire': instance.expire,
      'accessId': instance.accessId,
      'host': instance.host,
    };
