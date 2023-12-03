// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emoji_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EmojiModel _$EmojiModelFromJson(Map<String, dynamic> json) {
  return _EmojiModel.fromJson(json);
}

/// @nodoc
mixin _$EmojiModel {
  String? get id => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmojiModelCopyWith<EmojiModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmojiModelCopyWith<$Res> {
  factory $EmojiModelCopyWith(
          EmojiModel value, $Res Function(EmojiModel) then) =
      _$EmojiModelCopyWithImpl<$Res, EmojiModel>;
  @useResult
  $Res call({String? id, String image, String? text, String? color});
}

/// @nodoc
class _$EmojiModelCopyWithImpl<$Res, $Val extends EmojiModel>
    implements $EmojiModelCopyWith<$Res> {
  _$EmojiModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? image = null,
    Object? text = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$EmojiModelImplCopyWith<$Res>
    implements $EmojiModelCopyWith<$Res> {
  factory _$$EmojiModelImplCopyWith(
          _$EmojiModelImpl value, $Res Function(_$EmojiModelImpl) then) =
      __$$EmojiModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String image, String? text, String? color});
}

/// @nodoc
class __$$EmojiModelImplCopyWithImpl<$Res>
    extends _$EmojiModelCopyWithImpl<$Res, _$EmojiModelImpl>
    implements _$$EmojiModelImplCopyWith<$Res> {
  __$$EmojiModelImplCopyWithImpl(
      _$EmojiModelImpl _value, $Res Function(_$EmojiModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? image = null,
    Object? text = freezed,
    Object? color = freezed,
  }) {
    return _then(_$EmojiModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$EmojiModelImpl implements _EmojiModel {
  const _$EmojiModelImpl({this.id, this.image = '', this.text, this.color});

  factory _$EmojiModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmojiModelImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final String image;
  @override
  final String? text;
  @override
  final String? color;

  @override
  String toString() {
    return 'EmojiModel(id: $id, image: $image, text: $text, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmojiModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, image, text, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmojiModelImplCopyWith<_$EmojiModelImpl> get copyWith =>
      __$$EmojiModelImplCopyWithImpl<_$EmojiModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmojiModelImplToJson(
      this,
    );
  }
}

abstract class _EmojiModel implements EmojiModel {
  const factory _EmojiModel(
      {final String? id,
      final String image,
      final String? text,
      final String? color}) = _$EmojiModelImpl;

  factory _EmojiModel.fromJson(Map<String, dynamic> json) =
      _$EmojiModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get image;
  @override
  String? get text;
  @override
  String? get color;
  @override
  @JsonKey(ignore: true)
  _$$EmojiModelImplCopyWith<_$EmojiModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
