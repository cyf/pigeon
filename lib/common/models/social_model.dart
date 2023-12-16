import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_model.freezed.dart';
part 'social_model.g.dart';

@immutable
@freezed
class SocialModel with _$SocialModel {
  const factory SocialModel({
    String? title,
    List<SubTitle>? subtitles,
    List<Link>? tips,
    List<Description>? descriptions,
  }) = _SocialModel;

  /// Deserializes the given json into a [SocialModel].
  factory SocialModel.fromJson(Map<String, dynamic> json) =>
      _$SocialModelFromJson(json);
}

@immutable
@freezed
class SubTitle with _$SubTitle {
  const factory SubTitle({
    String? title,
    String? color,
  }) = _SubTitle;

  /// Deserializes the given json into a [SubTitle].
  factory SubTitle.fromJson(Map<String, dynamic> json) =>
      _$SubTitleFromJson(json);
}

@immutable
@freezed
class Description with _$Description {
  const factory Description({
    String? name,
    List<Link>? links,
  }) = _Description;

  /// Deserializes the given json into a [Description].
  factory Description.fromJson(Map<String, dynamic> json) =>
      _$DescriptionFromJson(json);
}

enum LinkType {
  link,
  text,
}

@immutable
@freezed
class Link with _$Link {
  const factory Link({
    LinkType? type,
    String? text,
    String? href,
    String? color,
  }) = _Link;

  /// Deserializes the given json into a [Link].
  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
}
