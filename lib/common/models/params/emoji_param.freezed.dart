// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emoji_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EmojiParam _$EmojiParamFromJson(Map<String, dynamic> json) {
  return _EmojiParam.fromJson(json);
}

/// @nodoc
mixin _$EmojiParam {
  String? get image => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  int? get size => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmojiParamCopyWith<EmojiParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmojiParamCopyWith<$Res> {
  factory $EmojiParamCopyWith(
          EmojiParam value, $Res Function(EmojiParam) then) =
      _$EmojiParamCopyWithImpl<$Res, EmojiParam>;
  @useResult
  $Res call(
      {String? image, String? type, int? size, String? text, String? color});
}

/// @nodoc
class _$EmojiParamCopyWithImpl<$Res, $Val extends EmojiParam>
    implements $EmojiParamCopyWith<$Res> {
  _$EmojiParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? type = freezed,
    Object? size = freezed,
    Object? text = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmojiParamImplCopyWith<$Res>
    implements $EmojiParamCopyWith<$Res> {
  factory _$$EmojiParamImplCopyWith(
          _$EmojiParamImpl value, $Res Function(_$EmojiParamImpl) then) =
      __$$EmojiParamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? image, String? type, int? size, String? text, String? color});
}

/// @nodoc
class __$$EmojiParamImplCopyWithImpl<$Res>
    extends _$EmojiParamCopyWithImpl<$Res, _$EmojiParamImpl>
    implements _$$EmojiParamImplCopyWith<$Res> {
  __$$EmojiParamImplCopyWithImpl(
      _$EmojiParamImpl _value, $Res Function(_$EmojiParamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? type = freezed,
    Object? size = freezed,
    Object? text = freezed,
    Object? color = freezed,
  }) {
    return _then(_$EmojiParamImpl(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmojiParamImpl implements _EmojiParam {
  const _$EmojiParamImpl(
      {this.image, this.type, this.size, this.text, this.color});

  factory _$EmojiParamImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmojiParamImplFromJson(json);

  @override
  final String? image;
  @override
  final String? type;
  @override
  final int? size;
  @override
  final String? text;
  @override
  final String? color;

  @override
  String toString() {
    return 'EmojiParam(image: $image, type: $type, size: $size, text: $text, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmojiParamImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, image, type, size, text, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmojiParamImplCopyWith<_$EmojiParamImpl> get copyWith =>
      __$$EmojiParamImplCopyWithImpl<_$EmojiParamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmojiParamImplToJson(
      this,
    );
  }
}

abstract class _EmojiParam implements EmojiParam {
  const factory _EmojiParam(
      {final String? image,
      final String? type,
      final int? size,
      final String? text,
      final String? color}) = _$EmojiParamImpl;

  factory _EmojiParam.fromJson(Map<String, dynamic> json) =
      _$EmojiParamImpl.fromJson;

  @override
  String? get image;
  @override
  String? get type;
  @override
  int? get size;
  @override
  String? get text;
  @override
  String? get color;
  @override
  @JsonKey(ignore: true)
  _$$EmojiParamImplCopyWith<_$EmojiParamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
