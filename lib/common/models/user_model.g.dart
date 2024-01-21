// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenModelImpl _$$TokenModelImplFromJson(Map<String, dynamic> json) =>
    _$TokenModelImpl(
      accessToken: json['access_token'] as String? ?? '',
      createSeconds: json['create_seconds'] as int? ?? 0,
      expireSeconds: json['expire_seconds'] as int? ?? 0,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TokenModelImplToJson(_$TokenModelImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'create_seconds': instance.createSeconds,
      'expire_seconds': instance.expireSeconds,
      'user': instance.user,
    };

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String?,
      username: json['username'] as String?,
      nickname: json['nickname'] as String?,
      email: json['email'] as String?,
      emailVerified: json['email_verified'] as bool? ?? false,
      phone: json['phone'] as String?,
      phoneVerified: json['phone_verified'] as bool? ?? false,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'email': instance.email,
      'email_verified': instance.emailVerified,
      'phone': instance.phone,
      'phone_verified': instance.phoneVerified,
      'avatar': instance.avatar,
    };
