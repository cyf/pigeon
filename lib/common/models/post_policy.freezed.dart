// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostPolicy _$PostPolicyFromJson(Map<String, dynamic> json) {
  return _PostPolicy.fromJson(json);
}

/// @nodoc
mixin _$PostPolicy {
  String? get policy => throw _privateConstructorUsedError;
  String? get signature => throw _privateConstructorUsedError;
  String? get dir => throw _privateConstructorUsedError;
  int? get expire => throw _privateConstructorUsedError;
  String? get accessId => throw _privateConstructorUsedError;
  String? get host => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostPolicyCopyWith<PostPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostPolicyCopyWith<$Res> {
  factory $PostPolicyCopyWith(
          PostPolicy value, $Res Function(PostPolicy) then) =
      _$PostPolicyCopyWithImpl<$Res, PostPolicy>;
  @useResult
  $Res call(
      {String? policy,
      String? signature,
      String? dir,
      int? expire,
      String? accessId,
      String? host});
}

/// @nodoc
class _$PostPolicyCopyWithImpl<$Res, $Val extends PostPolicy>
    implements $PostPolicyCopyWith<$Res> {
  _$PostPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? policy = freezed,
    Object? signature = freezed,
    Object? dir = freezed,
    Object? expire = freezed,
    Object? accessId = freezed,
    Object? host = freezed,
  }) {
    return _then(_value.copyWith(
      policy: freezed == policy
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as String?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      dir: freezed == dir
          ? _value.dir
          : dir // ignore: cast_nullable_to_non_nullable
              as String?,
      expire: freezed == expire
          ? _value.expire
          : expire // ignore: cast_nullable_to_non_nullable
              as int?,
      accessId: freezed == accessId
          ? _value.accessId
          : accessId // ignore: cast_nullable_to_non_nullable
              as String?,
      host: freezed == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostPolicyImplCopyWith<$Res>
    implements $PostPolicyCopyWith<$Res> {
  factory _$$PostPolicyImplCopyWith(
          _$PostPolicyImpl value, $Res Function(_$PostPolicyImpl) then) =
      __$$PostPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? policy,
      String? signature,
      String? dir,
      int? expire,
      String? accessId,
      String? host});
}

/// @nodoc
class __$$PostPolicyImplCopyWithImpl<$Res>
    extends _$PostPolicyCopyWithImpl<$Res, _$PostPolicyImpl>
    implements _$$PostPolicyImplCopyWith<$Res> {
  __$$PostPolicyImplCopyWithImpl(
      _$PostPolicyImpl _value, $Res Function(_$PostPolicyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? policy = freezed,
    Object? signature = freezed,
    Object? dir = freezed,
    Object? expire = freezed,
    Object? accessId = freezed,
    Object? host = freezed,
  }) {
    return _then(_$PostPolicyImpl(
      policy: freezed == policy
          ? _value.policy
          : policy // ignore: cast_nullable_to_non_nullable
              as String?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
      dir: freezed == dir
          ? _value.dir
          : dir // ignore: cast_nullable_to_non_nullable
              as String?,
      expire: freezed == expire
          ? _value.expire
          : expire // ignore: cast_nullable_to_non_nullable
              as int?,
      accessId: freezed == accessId
          ? _value.accessId
          : accessId // ignore: cast_nullable_to_non_nullable
              as String?,
      host: freezed == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostPolicyImpl implements _PostPolicy {
  const _$PostPolicyImpl(
      {this.policy,
      this.signature,
      this.dir,
      this.expire,
      this.accessId,
      this.host});

  factory _$PostPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostPolicyImplFromJson(json);

  @override
  final String? policy;
  @override
  final String? signature;
  @override
  final String? dir;
  @override
  final int? expire;
  @override
  final String? accessId;
  @override
  final String? host;

  @override
  String toString() {
    return 'PostPolicy(policy: $policy, signature: $signature, dir: $dir, expire: $expire, accessId: $accessId, host: $host)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostPolicyImpl &&
            (identical(other.policy, policy) || other.policy == policy) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.dir, dir) || other.dir == dir) &&
            (identical(other.expire, expire) || other.expire == expire) &&
            (identical(other.accessId, accessId) ||
                other.accessId == accessId) &&
            (identical(other.host, host) || other.host == host));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, policy, signature, dir, expire, accessId, host);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostPolicyImplCopyWith<_$PostPolicyImpl> get copyWith =>
      __$$PostPolicyImplCopyWithImpl<_$PostPolicyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostPolicyImplToJson(
      this,
    );
  }
}

abstract class _PostPolicy implements PostPolicy {
  const factory _PostPolicy(
      {final String? policy,
      final String? signature,
      final String? dir,
      final int? expire,
      final String? accessId,
      final String? host}) = _$PostPolicyImpl;

  factory _PostPolicy.fromJson(Map<String, dynamic> json) =
      _$PostPolicyImpl.fromJson;

  @override
  String? get policy;
  @override
  String? get signature;
  @override
  String? get dir;
  @override
  int? get expire;
  @override
  String? get accessId;
  @override
  String? get host;
  @override
  @JsonKey(ignore: true)
  _$$PostPolicyImplCopyWith<_$PostPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
