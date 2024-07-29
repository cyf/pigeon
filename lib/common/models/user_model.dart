// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@immutable
@freezed
class TokenModel with _$TokenModel {
  const factory TokenModel({
    @Default('')
    // ignore: invalid_annotation_target
    @JsonKey(name: 'access_token')
    String accessToken,
    @Default(0)
    // ignore: invalid_annotation_target
    @JsonKey(name: 'create_seconds')
    int createSeconds,
    @Default(0)
    // ignore: invalid_annotation_target
    @JsonKey(name: 'expire_seconds')
    int expireSeconds,
    UserModel? user,
  }) = _TokenModel;

  /// Deserializes the given json into a [TokenModel].
  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
}

@immutable
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? id,
    String? username,
    String? nickname,
    String? email,
    @Default(false)
    // ignore: invalid_annotation_target
    @JsonKey(name: 'email_verified')
    bool emailVerified,
    String? phone,
    @Default(false)
    // ignore: invalid_annotation_target
    @JsonKey(name: 'phone_verified')
    bool phoneVerified,
    String? avatar,
  }) = _UserModel;

  /// Deserializes the given json into a [UserModel].
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
