// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yt_video_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

YTVideoModel _$YTVideoModelFromJson(Map<String, dynamic> json) {
  return _YTVideoModel.fromJson(json);
}

/// @nodoc
mixin _$YTVideoModel {
  String? get kind => throw _privateConstructorUsedError;
  String? get etag => throw _privateConstructorUsedError;
  YTVideoId? get id => throw _privateConstructorUsedError;
  YTSnippet? get snippet => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $YTVideoModelCopyWith<YTVideoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YTVideoModelCopyWith<$Res> {
  factory $YTVideoModelCopyWith(
          YTVideoModel value, $Res Function(YTVideoModel) then) =
      _$YTVideoModelCopyWithImpl<$Res, YTVideoModel>;
  @useResult
  $Res call({String? kind, String? etag, YTVideoId? id, YTSnippet? snippet});

  $YTVideoIdCopyWith<$Res>? get id;
  $YTSnippetCopyWith<$Res>? get snippet;
}

/// @nodoc
class _$YTVideoModelCopyWithImpl<$Res, $Val extends YTVideoModel>
    implements $YTVideoModelCopyWith<$Res> {
  _$YTVideoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = freezed,
    Object? etag = freezed,
    Object? id = freezed,
    Object? snippet = freezed,
  }) {
    return _then(_value.copyWith(
      kind: freezed == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String?,
      etag: freezed == etag
          ? _value.etag
          : etag // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as YTVideoId?,
      snippet: freezed == snippet
          ? _value.snippet
          : snippet // ignore: cast_nullable_to_non_nullable
              as YTSnippet?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $YTVideoIdCopyWith<$Res>? get id {
    if (_value.id == null) {
      return null;
    }

    return $YTVideoIdCopyWith<$Res>(_value.id!, (value) {
      return _then(_value.copyWith(id: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $YTSnippetCopyWith<$Res>? get snippet {
    if (_value.snippet == null) {
      return null;
    }

    return $YTSnippetCopyWith<$Res>(_value.snippet!, (value) {
      return _then(_value.copyWith(snippet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$YTVideoModelImplCopyWith<$Res>
    implements $YTVideoModelCopyWith<$Res> {
  factory _$$YTVideoModelImplCopyWith(
          _$YTVideoModelImpl value, $Res Function(_$YTVideoModelImpl) then) =
      __$$YTVideoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? kind, String? etag, YTVideoId? id, YTSnippet? snippet});

  @override
  $YTVideoIdCopyWith<$Res>? get id;
  @override
  $YTSnippetCopyWith<$Res>? get snippet;
}

/// @nodoc
class __$$YTVideoModelImplCopyWithImpl<$Res>
    extends _$YTVideoModelCopyWithImpl<$Res, _$YTVideoModelImpl>
    implements _$$YTVideoModelImplCopyWith<$Res> {
  __$$YTVideoModelImplCopyWithImpl(
      _$YTVideoModelImpl _value, $Res Function(_$YTVideoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = freezed,
    Object? etag = freezed,
    Object? id = freezed,
    Object? snippet = freezed,
  }) {
    return _then(_$YTVideoModelImpl(
      kind: freezed == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String?,
      etag: freezed == etag
          ? _value.etag
          : etag // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as YTVideoId?,
      snippet: freezed == snippet
          ? _value.snippet
          : snippet // ignore: cast_nullable_to_non_nullable
              as YTSnippet?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YTVideoModelImpl implements _YTVideoModel {
  const _$YTVideoModelImpl({this.kind, this.etag, this.id, this.snippet});

  factory _$YTVideoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$YTVideoModelImplFromJson(json);

  @override
  final String? kind;
  @override
  final String? etag;
  @override
  final YTVideoId? id;
  @override
  final YTSnippet? snippet;

  @override
  String toString() {
    return 'YTVideoModel(kind: $kind, etag: $etag, id: $id, snippet: $snippet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YTVideoModelImpl &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.etag, etag) || other.etag == etag) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.snippet, snippet) || other.snippet == snippet));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, kind, etag, id, snippet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$YTVideoModelImplCopyWith<_$YTVideoModelImpl> get copyWith =>
      __$$YTVideoModelImplCopyWithImpl<_$YTVideoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YTVideoModelImplToJson(
      this,
    );
  }
}

abstract class _YTVideoModel implements YTVideoModel {
  const factory _YTVideoModel(
      {final String? kind,
      final String? etag,
      final YTVideoId? id,
      final YTSnippet? snippet}) = _$YTVideoModelImpl;

  factory _YTVideoModel.fromJson(Map<String, dynamic> json) =
      _$YTVideoModelImpl.fromJson;

  @override
  String? get kind;
  @override
  String? get etag;
  @override
  YTVideoId? get id;
  @override
  YTSnippet? get snippet;
  @override
  @JsonKey(ignore: true)
  _$$YTVideoModelImplCopyWith<_$YTVideoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YTVideoId _$YTVideoIdFromJson(Map<String, dynamic> json) {
  return _YTVideoId.fromJson(json);
}

/// @nodoc
mixin _$YTVideoId {
  String? get kind => throw _privateConstructorUsedError;
  String? get videoId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $YTVideoIdCopyWith<YTVideoId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YTVideoIdCopyWith<$Res> {
  factory $YTVideoIdCopyWith(YTVideoId value, $Res Function(YTVideoId) then) =
      _$YTVideoIdCopyWithImpl<$Res, YTVideoId>;
  @useResult
  $Res call({String? kind, String? videoId});
}

/// @nodoc
class _$YTVideoIdCopyWithImpl<$Res, $Val extends YTVideoId>
    implements $YTVideoIdCopyWith<$Res> {
  _$YTVideoIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = freezed,
    Object? videoId = freezed,
  }) {
    return _then(_value.copyWith(
      kind: freezed == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String?,
      videoId: freezed == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$YTVideoIdImplCopyWith<$Res>
    implements $YTVideoIdCopyWith<$Res> {
  factory _$$YTVideoIdImplCopyWith(
          _$YTVideoIdImpl value, $Res Function(_$YTVideoIdImpl) then) =
      __$$YTVideoIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? kind, String? videoId});
}

/// @nodoc
class __$$YTVideoIdImplCopyWithImpl<$Res>
    extends _$YTVideoIdCopyWithImpl<$Res, _$YTVideoIdImpl>
    implements _$$YTVideoIdImplCopyWith<$Res> {
  __$$YTVideoIdImplCopyWithImpl(
      _$YTVideoIdImpl _value, $Res Function(_$YTVideoIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = freezed,
    Object? videoId = freezed,
  }) {
    return _then(_$YTVideoIdImpl(
      kind: freezed == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as String?,
      videoId: freezed == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YTVideoIdImpl implements _YTVideoId {
  const _$YTVideoIdImpl({this.kind, this.videoId});

  factory _$YTVideoIdImpl.fromJson(Map<String, dynamic> json) =>
      _$$YTVideoIdImplFromJson(json);

  @override
  final String? kind;
  @override
  final String? videoId;

  @override
  String toString() {
    return 'YTVideoId(kind: $kind, videoId: $videoId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YTVideoIdImpl &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.videoId, videoId) || other.videoId == videoId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, kind, videoId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$YTVideoIdImplCopyWith<_$YTVideoIdImpl> get copyWith =>
      __$$YTVideoIdImplCopyWithImpl<_$YTVideoIdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YTVideoIdImplToJson(
      this,
    );
  }
}

abstract class _YTVideoId implements YTVideoId {
  const factory _YTVideoId({final String? kind, final String? videoId}) =
      _$YTVideoIdImpl;

  factory _YTVideoId.fromJson(Map<String, dynamic> json) =
      _$YTVideoIdImpl.fromJson;

  @override
  String? get kind;
  @override
  String? get videoId;
  @override
  @JsonKey(ignore: true)
  _$$YTVideoIdImplCopyWith<_$YTVideoIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YTSnippet _$YTSnippetFromJson(Map<String, dynamic> json) {
  return _YTSnippet.fromJson(json);
}

/// @nodoc
mixin _$YTSnippet {
  String? get publishedAt => throw _privateConstructorUsedError;
  String? get channelId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  YTThumbnails? get thumbnails => throw _privateConstructorUsedError;
  String? get channelTitle => throw _privateConstructorUsedError;
  String? get liveBroadcastContent => throw _privateConstructorUsedError;
  String? get publishTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $YTSnippetCopyWith<YTSnippet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YTSnippetCopyWith<$Res> {
  factory $YTSnippetCopyWith(YTSnippet value, $Res Function(YTSnippet) then) =
      _$YTSnippetCopyWithImpl<$Res, YTSnippet>;
  @useResult
  $Res call(
      {String? publishedAt,
      String? channelId,
      String? title,
      String? description,
      YTThumbnails? thumbnails,
      String? channelTitle,
      String? liveBroadcastContent,
      String? publishTime});

  $YTThumbnailsCopyWith<$Res>? get thumbnails;
}

/// @nodoc
class _$YTSnippetCopyWithImpl<$Res, $Val extends YTSnippet>
    implements $YTSnippetCopyWith<$Res> {
  _$YTSnippetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publishedAt = freezed,
    Object? channelId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? thumbnails = freezed,
    Object? channelTitle = freezed,
    Object? liveBroadcastContent = freezed,
    Object? publishTime = freezed,
  }) {
    return _then(_value.copyWith(
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      channelId: freezed == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnails: freezed == thumbnails
          ? _value.thumbnails
          : thumbnails // ignore: cast_nullable_to_non_nullable
              as YTThumbnails?,
      channelTitle: freezed == channelTitle
          ? _value.channelTitle
          : channelTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      liveBroadcastContent: freezed == liveBroadcastContent
          ? _value.liveBroadcastContent
          : liveBroadcastContent // ignore: cast_nullable_to_non_nullable
              as String?,
      publishTime: freezed == publishTime
          ? _value.publishTime
          : publishTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $YTThumbnailsCopyWith<$Res>? get thumbnails {
    if (_value.thumbnails == null) {
      return null;
    }

    return $YTThumbnailsCopyWith<$Res>(_value.thumbnails!, (value) {
      return _then(_value.copyWith(thumbnails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$YTSnippetImplCopyWith<$Res>
    implements $YTSnippetCopyWith<$Res> {
  factory _$$YTSnippetImplCopyWith(
          _$YTSnippetImpl value, $Res Function(_$YTSnippetImpl) then) =
      __$$YTSnippetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? publishedAt,
      String? channelId,
      String? title,
      String? description,
      YTThumbnails? thumbnails,
      String? channelTitle,
      String? liveBroadcastContent,
      String? publishTime});

  @override
  $YTThumbnailsCopyWith<$Res>? get thumbnails;
}

/// @nodoc
class __$$YTSnippetImplCopyWithImpl<$Res>
    extends _$YTSnippetCopyWithImpl<$Res, _$YTSnippetImpl>
    implements _$$YTSnippetImplCopyWith<$Res> {
  __$$YTSnippetImplCopyWithImpl(
      _$YTSnippetImpl _value, $Res Function(_$YTSnippetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publishedAt = freezed,
    Object? channelId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? thumbnails = freezed,
    Object? channelTitle = freezed,
    Object? liveBroadcastContent = freezed,
    Object? publishTime = freezed,
  }) {
    return _then(_$YTSnippetImpl(
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      channelId: freezed == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnails: freezed == thumbnails
          ? _value.thumbnails
          : thumbnails // ignore: cast_nullable_to_non_nullable
              as YTThumbnails?,
      channelTitle: freezed == channelTitle
          ? _value.channelTitle
          : channelTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      liveBroadcastContent: freezed == liveBroadcastContent
          ? _value.liveBroadcastContent
          : liveBroadcastContent // ignore: cast_nullable_to_non_nullable
              as String?,
      publishTime: freezed == publishTime
          ? _value.publishTime
          : publishTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YTSnippetImpl implements _YTSnippet {
  const _$YTSnippetImpl(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnails,
      this.channelTitle,
      this.liveBroadcastContent,
      this.publishTime});

  factory _$YTSnippetImpl.fromJson(Map<String, dynamic> json) =>
      _$$YTSnippetImplFromJson(json);

  @override
  final String? publishedAt;
  @override
  final String? channelId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final YTThumbnails? thumbnails;
  @override
  final String? channelTitle;
  @override
  final String? liveBroadcastContent;
  @override
  final String? publishTime;

  @override
  String toString() {
    return 'YTSnippet(publishedAt: $publishedAt, channelId: $channelId, title: $title, description: $description, thumbnails: $thumbnails, channelTitle: $channelTitle, liveBroadcastContent: $liveBroadcastContent, publishTime: $publishTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YTSnippetImpl &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumbnails, thumbnails) ||
                other.thumbnails == thumbnails) &&
            (identical(other.channelTitle, channelTitle) ||
                other.channelTitle == channelTitle) &&
            (identical(other.liveBroadcastContent, liveBroadcastContent) ||
                other.liveBroadcastContent == liveBroadcastContent) &&
            (identical(other.publishTime, publishTime) ||
                other.publishTime == publishTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, publishedAt, channelId, title,
      description, thumbnails, channelTitle, liveBroadcastContent, publishTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$YTSnippetImplCopyWith<_$YTSnippetImpl> get copyWith =>
      __$$YTSnippetImplCopyWithImpl<_$YTSnippetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YTSnippetImplToJson(
      this,
    );
  }
}

abstract class _YTSnippet implements YTSnippet {
  const factory _YTSnippet(
      {final String? publishedAt,
      final String? channelId,
      final String? title,
      final String? description,
      final YTThumbnails? thumbnails,
      final String? channelTitle,
      final String? liveBroadcastContent,
      final String? publishTime}) = _$YTSnippetImpl;

  factory _YTSnippet.fromJson(Map<String, dynamic> json) =
      _$YTSnippetImpl.fromJson;

  @override
  String? get publishedAt;
  @override
  String? get channelId;
  @override
  String? get title;
  @override
  String? get description;
  @override
  YTThumbnails? get thumbnails;
  @override
  String? get channelTitle;
  @override
  String? get liveBroadcastContent;
  @override
  String? get publishTime;
  @override
  @JsonKey(ignore: true)
  _$$YTSnippetImplCopyWith<_$YTSnippetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YTThumbnails _$YTThumbnailsFromJson(Map<String, dynamic> json) {
  return _YTThumbnails.fromJson(json);
}

/// @nodoc
mixin _$YTThumbnails {
  @JsonKey(name: 'default')
  YTThumbnail? get defaults => throw _privateConstructorUsedError;
  YTThumbnail? get medium => throw _privateConstructorUsedError;
  YTThumbnail? get high => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $YTThumbnailsCopyWith<YTThumbnails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YTThumbnailsCopyWith<$Res> {
  factory $YTThumbnailsCopyWith(
          YTThumbnails value, $Res Function(YTThumbnails) then) =
      _$YTThumbnailsCopyWithImpl<$Res, YTThumbnails>;
  @useResult
  $Res call(
      {@JsonKey(name: 'default') YTThumbnail? defaults,
      YTThumbnail? medium,
      YTThumbnail? high});

  $YTThumbnailCopyWith<$Res>? get defaults;
  $YTThumbnailCopyWith<$Res>? get medium;
  $YTThumbnailCopyWith<$Res>? get high;
}

/// @nodoc
class _$YTThumbnailsCopyWithImpl<$Res, $Val extends YTThumbnails>
    implements $YTThumbnailsCopyWith<$Res> {
  _$YTThumbnailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaults = freezed,
    Object? medium = freezed,
    Object? high = freezed,
  }) {
    return _then(_value.copyWith(
      defaults: freezed == defaults
          ? _value.defaults
          : defaults // ignore: cast_nullable_to_non_nullable
              as YTThumbnail?,
      medium: freezed == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as YTThumbnail?,
      high: freezed == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as YTThumbnail?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $YTThumbnailCopyWith<$Res>? get defaults {
    if (_value.defaults == null) {
      return null;
    }

    return $YTThumbnailCopyWith<$Res>(_value.defaults!, (value) {
      return _then(_value.copyWith(defaults: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $YTThumbnailCopyWith<$Res>? get medium {
    if (_value.medium == null) {
      return null;
    }

    return $YTThumbnailCopyWith<$Res>(_value.medium!, (value) {
      return _then(_value.copyWith(medium: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $YTThumbnailCopyWith<$Res>? get high {
    if (_value.high == null) {
      return null;
    }

    return $YTThumbnailCopyWith<$Res>(_value.high!, (value) {
      return _then(_value.copyWith(high: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$YTThumbnailsImplCopyWith<$Res>
    implements $YTThumbnailsCopyWith<$Res> {
  factory _$$YTThumbnailsImplCopyWith(
          _$YTThumbnailsImpl value, $Res Function(_$YTThumbnailsImpl) then) =
      __$$YTThumbnailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'default') YTThumbnail? defaults,
      YTThumbnail? medium,
      YTThumbnail? high});

  @override
  $YTThumbnailCopyWith<$Res>? get defaults;
  @override
  $YTThumbnailCopyWith<$Res>? get medium;
  @override
  $YTThumbnailCopyWith<$Res>? get high;
}

/// @nodoc
class __$$YTThumbnailsImplCopyWithImpl<$Res>
    extends _$YTThumbnailsCopyWithImpl<$Res, _$YTThumbnailsImpl>
    implements _$$YTThumbnailsImplCopyWith<$Res> {
  __$$YTThumbnailsImplCopyWithImpl(
      _$YTThumbnailsImpl _value, $Res Function(_$YTThumbnailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaults = freezed,
    Object? medium = freezed,
    Object? high = freezed,
  }) {
    return _then(_$YTThumbnailsImpl(
      defaults: freezed == defaults
          ? _value.defaults
          : defaults // ignore: cast_nullable_to_non_nullable
              as YTThumbnail?,
      medium: freezed == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as YTThumbnail?,
      high: freezed == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as YTThumbnail?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YTThumbnailsImpl implements _YTThumbnails {
  const _$YTThumbnailsImpl(
      {@JsonKey(name: 'default') this.defaults, this.medium, this.high});

  factory _$YTThumbnailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$YTThumbnailsImplFromJson(json);

  @override
  @JsonKey(name: 'default')
  final YTThumbnail? defaults;
  @override
  final YTThumbnail? medium;
  @override
  final YTThumbnail? high;

  @override
  String toString() {
    return 'YTThumbnails(defaults: $defaults, medium: $medium, high: $high)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YTThumbnailsImpl &&
            (identical(other.defaults, defaults) ||
                other.defaults == defaults) &&
            (identical(other.medium, medium) || other.medium == medium) &&
            (identical(other.high, high) || other.high == high));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, defaults, medium, high);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$YTThumbnailsImplCopyWith<_$YTThumbnailsImpl> get copyWith =>
      __$$YTThumbnailsImplCopyWithImpl<_$YTThumbnailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YTThumbnailsImplToJson(
      this,
    );
  }
}

abstract class _YTThumbnails implements YTThumbnails {
  const factory _YTThumbnails(
      {@JsonKey(name: 'default') final YTThumbnail? defaults,
      final YTThumbnail? medium,
      final YTThumbnail? high}) = _$YTThumbnailsImpl;

  factory _YTThumbnails.fromJson(Map<String, dynamic> json) =
      _$YTThumbnailsImpl.fromJson;

  @override
  @JsonKey(name: 'default')
  YTThumbnail? get defaults;
  @override
  YTThumbnail? get medium;
  @override
  YTThumbnail? get high;
  @override
  @JsonKey(ignore: true)
  _$$YTThumbnailsImplCopyWith<_$YTThumbnailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YTThumbnail _$YTThumbnailFromJson(Map<String, dynamic> json) {
  return _YTThumbnail.fromJson(json);
}

/// @nodoc
mixin _$YTThumbnail {
  String? get url => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $YTThumbnailCopyWith<YTThumbnail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YTThumbnailCopyWith<$Res> {
  factory $YTThumbnailCopyWith(
          YTThumbnail value, $Res Function(YTThumbnail) then) =
      _$YTThumbnailCopyWithImpl<$Res, YTThumbnail>;
  @useResult
  $Res call({String? url, int? width, int? height});
}

/// @nodoc
class _$YTThumbnailCopyWithImpl<$Res, $Val extends YTThumbnail>
    implements $YTThumbnailCopyWith<$Res> {
  _$YTThumbnailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$YTThumbnailImplCopyWith<$Res>
    implements $YTThumbnailCopyWith<$Res> {
  factory _$$YTThumbnailImplCopyWith(
          _$YTThumbnailImpl value, $Res Function(_$YTThumbnailImpl) then) =
      __$$YTThumbnailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url, int? width, int? height});
}

/// @nodoc
class __$$YTThumbnailImplCopyWithImpl<$Res>
    extends _$YTThumbnailCopyWithImpl<$Res, _$YTThumbnailImpl>
    implements _$$YTThumbnailImplCopyWith<$Res> {
  __$$YTThumbnailImplCopyWithImpl(
      _$YTThumbnailImpl _value, $Res Function(_$YTThumbnailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_$YTThumbnailImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YTThumbnailImpl implements _YTThumbnail {
  const _$YTThumbnailImpl({this.url, this.width, this.height});

  factory _$YTThumbnailImpl.fromJson(Map<String, dynamic> json) =>
      _$$YTThumbnailImplFromJson(json);

  @override
  final String? url;
  @override
  final int? width;
  @override
  final int? height;

  @override
  String toString() {
    return 'YTThumbnail(url: $url, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YTThumbnailImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, width, height);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$YTThumbnailImplCopyWith<_$YTThumbnailImpl> get copyWith =>
      __$$YTThumbnailImplCopyWithImpl<_$YTThumbnailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YTThumbnailImplToJson(
      this,
    );
  }
}

abstract class _YTThumbnail implements YTThumbnail {
  const factory _YTThumbnail(
      {final String? url,
      final int? width,
      final int? height}) = _$YTThumbnailImpl;

  factory _YTThumbnail.fromJson(Map<String, dynamic> json) =
      _$YTThumbnailImpl.fromJson;

  @override
  String? get url;
  @override
  int? get width;
  @override
  int? get height;
  @override
  @JsonKey(ignore: true)
  _$$YTThumbnailImplCopyWith<_$YTThumbnailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
