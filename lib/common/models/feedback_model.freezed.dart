// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FeedbackModel _$FeedbackModelFromJson(Map<String, dynamic> json) {
  return _FeedbackModel.fromJson(json);
}

/// @nodoc
mixin _$FeedbackModel {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<FeedbackFileModel>? get files => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedbackModelCopyWith<FeedbackModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedbackModelCopyWith<$Res> {
  factory $FeedbackModelCopyWith(
          FeedbackModel value, $Res Function(FeedbackModel) then) =
      _$FeedbackModelCopyWithImpl<$Res, FeedbackModel>;
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? description,
      List<FeedbackFileModel>? files});
}

/// @nodoc
class _$FeedbackModelCopyWithImpl<$Res, $Val extends FeedbackModel>
    implements $FeedbackModelCopyWith<$Res> {
  _$FeedbackModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? files = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      files: freezed == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<FeedbackFileModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedbackModelImplCopyWith<$Res>
    implements $FeedbackModelCopyWith<$Res> {
  factory _$$FeedbackModelImplCopyWith(
          _$FeedbackModelImpl value, $Res Function(_$FeedbackModelImpl) then) =
      __$$FeedbackModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? title,
      String? description,
      List<FeedbackFileModel>? files});
}

/// @nodoc
class __$$FeedbackModelImplCopyWithImpl<$Res>
    extends _$FeedbackModelCopyWithImpl<$Res, _$FeedbackModelImpl>
    implements _$$FeedbackModelImplCopyWith<$Res> {
  __$$FeedbackModelImplCopyWithImpl(
      _$FeedbackModelImpl _value, $Res Function(_$FeedbackModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? files = freezed,
  }) {
    return _then(_$FeedbackModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      files: freezed == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<FeedbackFileModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedbackModelImpl implements _FeedbackModel {
  const _$FeedbackModelImpl(
      {this.id,
      this.title,
      this.description,
      final List<FeedbackFileModel>? files})
      : _files = files;

  factory _$FeedbackModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedbackModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? description;
  final List<FeedbackFileModel>? _files;
  @override
  List<FeedbackFileModel>? get files {
    final value = _files;
    if (value == null) return null;
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FeedbackModel(id: $id, title: $title, description: $description, files: $files)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedbackModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      const DeepCollectionEquality().hash(_files));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedbackModelImplCopyWith<_$FeedbackModelImpl> get copyWith =>
      __$$FeedbackModelImplCopyWithImpl<_$FeedbackModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedbackModelImplToJson(
      this,
    );
  }
}

abstract class _FeedbackModel implements FeedbackModel {
  const factory _FeedbackModel(
      {final String? id,
      final String? title,
      final String? description,
      final List<FeedbackFileModel>? files}) = _$FeedbackModelImpl;

  factory _FeedbackModel.fromJson(Map<String, dynamic> json) =
      _$FeedbackModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get description;
  @override
  List<FeedbackFileModel>? get files;
  @override
  @JsonKey(ignore: true)
  _$$FeedbackModelImplCopyWith<_$FeedbackModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeedbackFileModel _$FeedbackFileModelFromJson(Map<String, dynamic> json) {
  return _FeedbackFileModel.fromJson(json);
}

/// @nodoc
mixin _$FeedbackFileModel {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'feedback_id')
  String? get feedbackId => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  int? get size => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedbackFileModelCopyWith<FeedbackFileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedbackFileModelCopyWith<$Res> {
  factory $FeedbackFileModelCopyWith(
          FeedbackFileModel value, $Res Function(FeedbackFileModel) then) =
      _$FeedbackFileModelCopyWithImpl<$Res, FeedbackFileModel>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'feedback_id') String? feedbackId,
      String? url,
      String? type,
      int? size,
      String? title});
}

/// @nodoc
class _$FeedbackFileModelCopyWithImpl<$Res, $Val extends FeedbackFileModel>
    implements $FeedbackFileModelCopyWith<$Res> {
  _$FeedbackFileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? feedbackId = freezed,
    Object? url = freezed,
    Object? type = freezed,
    Object? size = freezed,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      feedbackId: freezed == feedbackId
          ? _value.feedbackId
          : feedbackId // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedbackFileModelImplCopyWith<$Res>
    implements $FeedbackFileModelCopyWith<$Res> {
  factory _$$FeedbackFileModelImplCopyWith(_$FeedbackFileModelImpl value,
          $Res Function(_$FeedbackFileModelImpl) then) =
      __$$FeedbackFileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'feedback_id') String? feedbackId,
      String? url,
      String? type,
      int? size,
      String? title});
}

/// @nodoc
class __$$FeedbackFileModelImplCopyWithImpl<$Res>
    extends _$FeedbackFileModelCopyWithImpl<$Res, _$FeedbackFileModelImpl>
    implements _$$FeedbackFileModelImplCopyWith<$Res> {
  __$$FeedbackFileModelImplCopyWithImpl(_$FeedbackFileModelImpl _value,
      $Res Function(_$FeedbackFileModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? feedbackId = freezed,
    Object? url = freezed,
    Object? type = freezed,
    Object? size = freezed,
    Object? title = freezed,
  }) {
    return _then(_$FeedbackFileModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      feedbackId: freezed == feedbackId
          ? _value.feedbackId
          : feedbackId // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedbackFileModelImpl implements _FeedbackFileModel {
  const _$FeedbackFileModelImpl(
      {this.id,
      @JsonKey(name: 'feedback_id') this.feedbackId,
      this.url,
      this.type,
      this.size,
      this.title});

  factory _$FeedbackFileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedbackFileModelImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'feedback_id')
  final String? feedbackId;
  @override
  final String? url;
  @override
  final String? type;
  @override
  final int? size;
  @override
  final String? title;

  @override
  String toString() {
    return 'FeedbackFileModel(id: $id, feedbackId: $feedbackId, url: $url, type: $type, size: $size, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedbackFileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.feedbackId, feedbackId) ||
                other.feedbackId == feedbackId) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, feedbackId, url, type, size, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedbackFileModelImplCopyWith<_$FeedbackFileModelImpl> get copyWith =>
      __$$FeedbackFileModelImplCopyWithImpl<_$FeedbackFileModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedbackFileModelImplToJson(
      this,
    );
  }
}

abstract class _FeedbackFileModel implements FeedbackFileModel {
  const factory _FeedbackFileModel(
      {final String? id,
      @JsonKey(name: 'feedback_id') final String? feedbackId,
      final String? url,
      final String? type,
      final int? size,
      final String? title}) = _$FeedbackFileModelImpl;

  factory _FeedbackFileModel.fromJson(Map<String, dynamic> json) =
      _$FeedbackFileModelImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'feedback_id')
  String? get feedbackId;
  @override
  String? get url;
  @override
  String? get type;
  @override
  int? get size;
  @override
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$FeedbackFileModelImplCopyWith<_$FeedbackFileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
