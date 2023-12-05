import 'package:freezed_annotation/freezed_annotation.dart';

part 'emoji_param.freezed.dart';
part 'emoji_param.g.dart';

@immutable
@freezed
class EmojiParam with _$EmojiParam {
  const factory EmojiParam({
    String? image,
    String? type,
    int? size,
    String? text,
    String? color,
  }) = _EmojiParam;

  /// Deserializes the given json into a [EmojiParam].
  factory EmojiParam.fromJson(Map<String, dynamic> json) =>
      _$EmojiParamFromJson(json);
}
