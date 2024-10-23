// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'carousel_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CarouselModel _$CarouselModelFromJson(Map<String, dynamic> json) {
  return _CarouselModel.fromJson(json);
}

/// @nodoc
mixin _$CarouselModel {
  String? get id => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get href => throw _privateConstructorUsedError;

  /// Serializes this CarouselModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CarouselModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CarouselModelCopyWith<CarouselModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarouselModelCopyWith<$Res> {
  factory $CarouselModelCopyWith(
          CarouselModel value, $Res Function(CarouselModel) then) =
      _$CarouselModelCopyWithImpl<$Res, CarouselModel>;
  @useResult
  $Res call(
      {String? id,
      String image,
      int order,
      String? text,
      String? color,
      String? href});
}

/// @nodoc
class _$CarouselModelCopyWithImpl<$Res, $Val extends CarouselModel>
    implements $CarouselModelCopyWith<$Res> {
  _$CarouselModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CarouselModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? image = null,
    Object? order = null,
    Object? text = freezed,
    Object? color = freezed,
    Object? href = freezed,
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
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      href: freezed == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CarouselModelImplCopyWith<$Res>
    implements $CarouselModelCopyWith<$Res> {
  factory _$$CarouselModelImplCopyWith(
          _$CarouselModelImpl value, $Res Function(_$CarouselModelImpl) then) =
      __$$CarouselModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String image,
      int order,
      String? text,
      String? color,
      String? href});
}

/// @nodoc
class __$$CarouselModelImplCopyWithImpl<$Res>
    extends _$CarouselModelCopyWithImpl<$Res, _$CarouselModelImpl>
    implements _$$CarouselModelImplCopyWith<$Res> {
  __$$CarouselModelImplCopyWithImpl(
      _$CarouselModelImpl _value, $Res Function(_$CarouselModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CarouselModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? image = null,
    Object? order = null,
    Object? text = freezed,
    Object? color = freezed,
    Object? href = freezed,
  }) {
    return _then(_$CarouselModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      href: freezed == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CarouselModelImpl implements _CarouselModel {
  const _$CarouselModelImpl(
      {this.id,
      this.image = '',
      this.order = 0,
      this.text,
      this.color,
      this.href});

  factory _$CarouselModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CarouselModelImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final String image;
  @override
  @JsonKey()
  final int order;
  @override
  final String? text;
  @override
  final String? color;
  @override
  final String? href;

  @override
  String toString() {
    return 'CarouselModel(id: $id, image: $image, order: $order, text: $text, color: $color, href: $href)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CarouselModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.href, href) || other.href == href));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, image, order, text, color, href);

  /// Create a copy of CarouselModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CarouselModelImplCopyWith<_$CarouselModelImpl> get copyWith =>
      __$$CarouselModelImplCopyWithImpl<_$CarouselModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CarouselModelImplToJson(
      this,
    );
  }
}

abstract class _CarouselModel implements CarouselModel {
  const factory _CarouselModel(
      {final String? id,
      final String image,
      final int order,
      final String? text,
      final String? color,
      final String? href}) = _$CarouselModelImpl;

  factory _CarouselModel.fromJson(Map<String, dynamic> json) =
      _$CarouselModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get image;
  @override
  int get order;
  @override
  String? get text;
  @override
  String? get color;
  @override
  String? get href;

  /// Create a copy of CarouselModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CarouselModelImplCopyWith<_$CarouselModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
