// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roadmap_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoadmapModel _$RoadmapModelFromJson(Map<String, dynamic> json) {
  return _RoadmapModel.fromJson(json);
}

/// @nodoc
mixin _$RoadmapModel {
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get from => throw _privateConstructorUsedError;
  DateTime? get to => throw _privateConstructorUsedError;
  String? get background => throw _privateConstructorUsedError;
  bool get isAllDay => throw _privateConstructorUsedError;
  List<Tag>? get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoadmapModelCopyWith<RoadmapModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoadmapModelCopyWith<$Res> {
  factory $RoadmapModelCopyWith(
          RoadmapModel value, $Res Function(RoadmapModel) then) =
      _$RoadmapModelCopyWithImpl<$Res, RoadmapModel>;
  @useResult
  $Res call(
      {String? title,
      String? description,
      DateTime? from,
      DateTime? to,
      String? background,
      bool isAllDay,
      List<Tag>? tags});
}

/// @nodoc
class _$RoadmapModelCopyWithImpl<$Res, $Val extends RoadmapModel>
    implements $RoadmapModelCopyWith<$Res> {
  _$RoadmapModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? background = freezed,
    Object? isAllDay = null,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoadmapModelImplCopyWith<$Res>
    implements $RoadmapModelCopyWith<$Res> {
  factory _$$RoadmapModelImplCopyWith(
          _$RoadmapModelImpl value, $Res Function(_$RoadmapModelImpl) then) =
      __$$RoadmapModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? description,
      DateTime? from,
      DateTime? to,
      String? background,
      bool isAllDay,
      List<Tag>? tags});
}

/// @nodoc
class __$$RoadmapModelImplCopyWithImpl<$Res>
    extends _$RoadmapModelCopyWithImpl<$Res, _$RoadmapModelImpl>
    implements _$$RoadmapModelImplCopyWith<$Res> {
  __$$RoadmapModelImplCopyWithImpl(
      _$RoadmapModelImpl _value, $Res Function(_$RoadmapModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? background = freezed,
    Object? isAllDay = null,
    Object? tags = freezed,
  }) {
    return _then(_$RoadmapModelImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoadmapModelImpl implements _RoadmapModel {
  const _$RoadmapModelImpl(
      {this.title,
      this.description,
      this.from,
      this.to,
      this.background,
      this.isAllDay = false,
      final List<Tag>? tags})
      : _tags = tags;

  factory _$RoadmapModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoadmapModelImplFromJson(json);

  @override
  final String? title;
  @override
  final String? description;
  @override
  final DateTime? from;
  @override
  final DateTime? to;
  @override
  final String? background;
  @override
  @JsonKey()
  final bool isAllDay;
  final List<Tag>? _tags;
  @override
  List<Tag>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RoadmapModel(title: $title, description: $description, from: $from, to: $to, background: $background, isAllDay: $isAllDay, tags: $tags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoadmapModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.background, background) ||
                other.background == background) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, from, to,
      background, isAllDay, const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoadmapModelImplCopyWith<_$RoadmapModelImpl> get copyWith =>
      __$$RoadmapModelImplCopyWithImpl<_$RoadmapModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoadmapModelImplToJson(
      this,
    );
  }
}

abstract class _RoadmapModel implements RoadmapModel {
  const factory _RoadmapModel(
      {final String? title,
      final String? description,
      final DateTime? from,
      final DateTime? to,
      final String? background,
      final bool isAllDay,
      final List<Tag>? tags}) = _$RoadmapModelImpl;

  factory _RoadmapModel.fromJson(Map<String, dynamic> json) =
      _$RoadmapModelImpl.fromJson;

  @override
  String? get title;
  @override
  String? get description;
  @override
  DateTime? get from;
  @override
  DateTime? get to;
  @override
  String? get background;
  @override
  bool get isAllDay;
  @override
  List<Tag>? get tags;
  @override
  @JsonKey(ignore: true)
  _$$RoadmapModelImplCopyWith<_$RoadmapModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Tag _$TagFromJson(Map<String, dynamic> json) {
  return _Tag.fromJson(json);
}

/// @nodoc
mixin _$Tag {
  String? get title => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagCopyWith<Tag> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagCopyWith<$Res> {
  factory $TagCopyWith(Tag value, $Res Function(Tag) then) =
      _$TagCopyWithImpl<$Res, Tag>;
  @useResult
  $Res call({String? title, String? color});
}

/// @nodoc
class _$TagCopyWithImpl<$Res, $Val extends Tag> implements $TagCopyWith<$Res> {
  _$TagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagImplCopyWith<$Res> implements $TagCopyWith<$Res> {
  factory _$$TagImplCopyWith(_$TagImpl value, $Res Function(_$TagImpl) then) =
      __$$TagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String? color});
}

/// @nodoc
class __$$TagImplCopyWithImpl<$Res> extends _$TagCopyWithImpl<$Res, _$TagImpl>
    implements _$$TagImplCopyWith<$Res> {
  __$$TagImplCopyWithImpl(_$TagImpl _value, $Res Function(_$TagImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? color = freezed,
  }) {
    return _then(_$TagImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
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
class _$TagImpl implements _Tag {
  const _$TagImpl({this.title, this.color});

  factory _$TagImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagImplFromJson(json);

  @override
  final String? title;
  @override
  final String? color;

  @override
  String toString() {
    return 'Tag(title: $title, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagImplCopyWith<_$TagImpl> get copyWith =>
      __$$TagImplCopyWithImpl<_$TagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagImplToJson(
      this,
    );
  }
}

abstract class _Tag implements Tag {
  const factory _Tag({final String? title, final String? color}) = _$TagImpl;

  factory _Tag.fromJson(Map<String, dynamic> json) = _$TagImpl.fromJson;

  @override
  String? get title;
  @override
  String? get color;
  @override
  @JsonKey(ignore: true)
  _$$TagImplCopyWith<_$TagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
