import 'package:freezed_annotation/freezed_annotation.dart';

part 'yt_video_model.freezed.dart';
part 'yt_video_model.g.dart';

@immutable
@freezed
class YTVideoModel with _$YTVideoModel {
  const factory YTVideoModel({
    String? kind,
    String? etag,
    YTVideoId? id,
    YTSnippet? snippet,
  }) = _YTVideoModel;

  /// Deserializes the given json into a [YTVideoModel].
  factory YTVideoModel.fromJson(Map<String, dynamic> json) =>
      _$YTVideoModelFromJson(json);
}

@immutable
@freezed
class YTVideoId with _$YTVideoId {
  const factory YTVideoId({
    String? kind,
    String? videoId,
  }) = _YTVideoId;

  /// Deserializes the given json into a [YTVideoId].
  factory YTVideoId.fromJson(Map<String, dynamic> json) =>
      _$YTVideoIdFromJson(json);
}

@immutable
@freezed
class YTSnippet with _$YTSnippet {
  const factory YTSnippet({
    String? publishedAt,
    String? channelId,
    String? title,
    String? description,
    YTThumbnails? thumbnails,
    String? channelTitle,
    String? liveBroadcastContent,
    String? publishTime,
  }) = _YTSnippet;

  /// Deserializes the given json into a [YTSnippet].
  factory YTSnippet.fromJson(Map<String, dynamic> json) =>
      _$YTSnippetFromJson(json);
}

@immutable
@freezed
class YTThumbnails with _$YTThumbnails {
  const factory YTThumbnails({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'default')
    YTThumbnail? defaults,
    YTThumbnail? medium,
    YTThumbnail? high,
  }) = _YTThumbnails;

  /// Deserializes the given json into a [YTThumbnails].
  factory YTThumbnails.fromJson(Map<String, dynamic> json) =>
      _$YTThumbnailsFromJson(json);
}

@immutable
@freezed
class YTThumbnail with _$YTThumbnail {
  const factory YTThumbnail({
    String? url,
    int? width,
    int? height,
  }) = _YTThumbnail;

  /// Deserializes the given json into a [YTThumbnail].
  factory YTThumbnail.fromJson(Map<String, dynamic> json) =>
      _$YTThumbnailFromJson(json);
}
