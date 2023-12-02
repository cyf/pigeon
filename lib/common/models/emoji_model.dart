import 'package:freezed_annotation/freezed_annotation.dart';

part 'emoji_model.freezed.dart';
part 'emoji_model.g.dart';

@immutable
@freezed
class EmojiModel with _$EmojiModel {
  const factory EmojiModel({
    String? id,
    @Default('')
    String image,
    String? text,
  }) = _EmojiModel;

  /// Deserializes the given json into a [EmojiModel].
  factory EmojiModel.fromJson(Map<String, dynamic> json) =>
      _$EmojiModelFromJson(json);
}
