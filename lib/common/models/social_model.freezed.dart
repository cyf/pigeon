// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SocialModel _$SocialModelFromJson(Map<String, dynamic> json) {
  return _SocialModel.fromJson(json);
}

/// @nodoc
mixin _$SocialModel {
  String? get title => throw _privateConstructorUsedError;
  List<SubTitle>? get subtitles => throw _privateConstructorUsedError;
  List<Link>? get tips => throw _privateConstructorUsedError;
  List<Description>? get descriptions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SocialModelCopyWith<SocialModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialModelCopyWith<$Res> {
  factory $SocialModelCopyWith(
          SocialModel value, $Res Function(SocialModel) then) =
      _$SocialModelCopyWithImpl<$Res, SocialModel>;
  @useResult
  $Res call(
      {String? title,
      List<SubTitle>? subtitles,
      List<Link>? tips,
      List<Description>? descriptions});
}

/// @nodoc
class _$SocialModelCopyWithImpl<$Res, $Val extends SocialModel>
    implements $SocialModelCopyWith<$Res> {
  _$SocialModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? subtitles = freezed,
    Object? tips = freezed,
    Object? descriptions = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subtitles: freezed == subtitles
          ? _value.subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<SubTitle>?,
      tips: freezed == tips
          ? _value.tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<Link>?,
      descriptions: freezed == descriptions
          ? _value.descriptions
          : descriptions // ignore: cast_nullable_to_non_nullable
              as List<Description>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SocialModelImplCopyWith<$Res>
    implements $SocialModelCopyWith<$Res> {
  factory _$$SocialModelImplCopyWith(
          _$SocialModelImpl value, $Res Function(_$SocialModelImpl) then) =
      __$$SocialModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      List<SubTitle>? subtitles,
      List<Link>? tips,
      List<Description>? descriptions});
}

/// @nodoc
class __$$SocialModelImplCopyWithImpl<$Res>
    extends _$SocialModelCopyWithImpl<$Res, _$SocialModelImpl>
    implements _$$SocialModelImplCopyWith<$Res> {
  __$$SocialModelImplCopyWithImpl(
      _$SocialModelImpl _value, $Res Function(_$SocialModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? subtitles = freezed,
    Object? tips = freezed,
    Object? descriptions = freezed,
  }) {
    return _then(_$SocialModelImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subtitles: freezed == subtitles
          ? _value._subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<SubTitle>?,
      tips: freezed == tips
          ? _value._tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<Link>?,
      descriptions: freezed == descriptions
          ? _value._descriptions
          : descriptions // ignore: cast_nullable_to_non_nullable
              as List<Description>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SocialModelImpl implements _SocialModel {
  const _$SocialModelImpl(
      {this.title,
      final List<SubTitle>? subtitles,
      final List<Link>? tips,
      final List<Description>? descriptions})
      : _subtitles = subtitles,
        _tips = tips,
        _descriptions = descriptions;

  factory _$SocialModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocialModelImplFromJson(json);

  @override
  final String? title;
  final List<SubTitle>? _subtitles;
  @override
  List<SubTitle>? get subtitles {
    final value = _subtitles;
    if (value == null) return null;
    if (_subtitles is EqualUnmodifiableListView) return _subtitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Link>? _tips;
  @override
  List<Link>? get tips {
    final value = _tips;
    if (value == null) return null;
    if (_tips is EqualUnmodifiableListView) return _tips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Description>? _descriptions;
  @override
  List<Description>? get descriptions {
    final value = _descriptions;
    if (value == null) return null;
    if (_descriptions is EqualUnmodifiableListView) return _descriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SocialModel(title: $title, subtitles: $subtitles, tips: $tips, descriptions: $descriptions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._subtitles, _subtitles) &&
            const DeepCollectionEquality().equals(other._tips, _tips) &&
            const DeepCollectionEquality()
                .equals(other._descriptions, _descriptions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_subtitles),
      const DeepCollectionEquality().hash(_tips),
      const DeepCollectionEquality().hash(_descriptions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialModelImplCopyWith<_$SocialModelImpl> get copyWith =>
      __$$SocialModelImplCopyWithImpl<_$SocialModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SocialModelImplToJson(
      this,
    );
  }
}

abstract class _SocialModel implements SocialModel {
  const factory _SocialModel(
      {final String? title,
      final List<SubTitle>? subtitles,
      final List<Link>? tips,
      final List<Description>? descriptions}) = _$SocialModelImpl;

  factory _SocialModel.fromJson(Map<String, dynamic> json) =
      _$SocialModelImpl.fromJson;

  @override
  String? get title;
  @override
  List<SubTitle>? get subtitles;
  @override
  List<Link>? get tips;
  @override
  List<Description>? get descriptions;
  @override
  @JsonKey(ignore: true)
  _$$SocialModelImplCopyWith<_$SocialModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubTitle _$SubTitleFromJson(Map<String, dynamic> json) {
  return _SubTitle.fromJson(json);
}

/// @nodoc
mixin _$SubTitle {
  String? get title => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubTitleCopyWith<SubTitle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubTitleCopyWith<$Res> {
  factory $SubTitleCopyWith(SubTitle value, $Res Function(SubTitle) then) =
      _$SubTitleCopyWithImpl<$Res, SubTitle>;
  @useResult
  $Res call({String? title, String? color});
}

/// @nodoc
class _$SubTitleCopyWithImpl<$Res, $Val extends SubTitle>
    implements $SubTitleCopyWith<$Res> {
  _$SubTitleCopyWithImpl(this._value, this._then);

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
abstract class _$$SubTitleImplCopyWith<$Res>
    implements $SubTitleCopyWith<$Res> {
  factory _$$SubTitleImplCopyWith(
          _$SubTitleImpl value, $Res Function(_$SubTitleImpl) then) =
      __$$SubTitleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String? color});
}

/// @nodoc
class __$$SubTitleImplCopyWithImpl<$Res>
    extends _$SubTitleCopyWithImpl<$Res, _$SubTitleImpl>
    implements _$$SubTitleImplCopyWith<$Res> {
  __$$SubTitleImplCopyWithImpl(
      _$SubTitleImpl _value, $Res Function(_$SubTitleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? color = freezed,
  }) {
    return _then(_$SubTitleImpl(
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
class _$SubTitleImpl implements _SubTitle {
  const _$SubTitleImpl({this.title, this.color});

  factory _$SubTitleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubTitleImplFromJson(json);

  @override
  final String? title;
  @override
  final String? color;

  @override
  String toString() {
    return 'SubTitle(title: $title, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubTitleImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubTitleImplCopyWith<_$SubTitleImpl> get copyWith =>
      __$$SubTitleImplCopyWithImpl<_$SubTitleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubTitleImplToJson(
      this,
    );
  }
}

abstract class _SubTitle implements SubTitle {
  const factory _SubTitle({final String? title, final String? color}) =
      _$SubTitleImpl;

  factory _SubTitle.fromJson(Map<String, dynamic> json) =
      _$SubTitleImpl.fromJson;

  @override
  String? get title;
  @override
  String? get color;
  @override
  @JsonKey(ignore: true)
  _$$SubTitleImplCopyWith<_$SubTitleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Description _$DescriptionFromJson(Map<String, dynamic> json) {
  return _Description.fromJson(json);
}

/// @nodoc
mixin _$Description {
  String? get name => throw _privateConstructorUsedError;
  List<Link>? get links => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DescriptionCopyWith<Description> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DescriptionCopyWith<$Res> {
  factory $DescriptionCopyWith(
          Description value, $Res Function(Description) then) =
      _$DescriptionCopyWithImpl<$Res, Description>;
  @useResult
  $Res call({String? name, List<Link>? links});
}

/// @nodoc
class _$DescriptionCopyWithImpl<$Res, $Val extends Description>
    implements $DescriptionCopyWith<$Res> {
  _$DescriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? links = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Link>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DescriptionImplCopyWith<$Res>
    implements $DescriptionCopyWith<$Res> {
  factory _$$DescriptionImplCopyWith(
          _$DescriptionImpl value, $Res Function(_$DescriptionImpl) then) =
      __$$DescriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, List<Link>? links});
}

/// @nodoc
class __$$DescriptionImplCopyWithImpl<$Res>
    extends _$DescriptionCopyWithImpl<$Res, _$DescriptionImpl>
    implements _$$DescriptionImplCopyWith<$Res> {
  __$$DescriptionImplCopyWithImpl(
      _$DescriptionImpl _value, $Res Function(_$DescriptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? links = freezed,
  }) {
    return _then(_$DescriptionImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Link>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DescriptionImpl implements _Description {
  const _$DescriptionImpl({this.name, final List<Link>? links})
      : _links = links;

  factory _$DescriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DescriptionImplFromJson(json);

  @override
  final String? name;
  final List<Link>? _links;
  @override
  List<Link>? get links {
    final value = _links;
    if (value == null) return null;
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Description(name: $name, links: $links)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DescriptionImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._links, _links));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_links));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DescriptionImplCopyWith<_$DescriptionImpl> get copyWith =>
      __$$DescriptionImplCopyWithImpl<_$DescriptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DescriptionImplToJson(
      this,
    );
  }
}

abstract class _Description implements Description {
  const factory _Description({final String? name, final List<Link>? links}) =
      _$DescriptionImpl;

  factory _Description.fromJson(Map<String, dynamic> json) =
      _$DescriptionImpl.fromJson;

  @override
  String? get name;
  @override
  List<Link>? get links;
  @override
  @JsonKey(ignore: true)
  _$$DescriptionImplCopyWith<_$DescriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Link _$LinkFromJson(Map<String, dynamic> json) {
  return _Link.fromJson(json);
}

/// @nodoc
mixin _$Link {
  LinkType? get type => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get href => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LinkCopyWith<Link> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkCopyWith<$Res> {
  factory $LinkCopyWith(Link value, $Res Function(Link) then) =
      _$LinkCopyWithImpl<$Res, Link>;
  @useResult
  $Res call({LinkType? type, String? text, String? href, String? color});
}

/// @nodoc
class _$LinkCopyWithImpl<$Res, $Val extends Link>
    implements $LinkCopyWith<$Res> {
  _$LinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? text = freezed,
    Object? href = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LinkType?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      href: freezed == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LinkImplCopyWith<$Res> implements $LinkCopyWith<$Res> {
  factory _$$LinkImplCopyWith(
          _$LinkImpl value, $Res Function(_$LinkImpl) then) =
      __$$LinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LinkType? type, String? text, String? href, String? color});
}

/// @nodoc
class __$$LinkImplCopyWithImpl<$Res>
    extends _$LinkCopyWithImpl<$Res, _$LinkImpl>
    implements _$$LinkImplCopyWith<$Res> {
  __$$LinkImplCopyWithImpl(_$LinkImpl _value, $Res Function(_$LinkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? text = freezed,
    Object? href = freezed,
    Object? color = freezed,
  }) {
    return _then(_$LinkImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LinkType?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      href: freezed == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
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
class _$LinkImpl implements _Link {
  const _$LinkImpl({this.type, this.text, this.href, this.color});

  factory _$LinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkImplFromJson(json);

  @override
  final LinkType? type;
  @override
  final String? text;
  @override
  final String? href;
  @override
  final String? color;

  @override
  String toString() {
    return 'Link(type: $type, text: $text, href: $href, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.href, href) || other.href == href) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, text, href, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkImplCopyWith<_$LinkImpl> get copyWith =>
      __$$LinkImplCopyWithImpl<_$LinkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkImplToJson(
      this,
    );
  }
}

abstract class _Link implements Link {
  const factory _Link(
      {final LinkType? type,
      final String? text,
      final String? href,
      final String? color}) = _$LinkImpl;

  factory _Link.fromJson(Map<String, dynamic> json) = _$LinkImpl.fromJson;

  @override
  LinkType? get type;
  @override
  String? get text;
  @override
  String? get href;
  @override
  String? get color;
  @override
  @JsonKey(ignore: true)
  _$$LinkImplCopyWith<_$LinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
