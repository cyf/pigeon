// Dart imports:
import 'dart:async';

// Project imports:
import 'package:pigeon/common/http/hp_http.dart';
import 'package:pigeon/common/models/models.dart';

class EmojiApi {
  /// 小德表情包🐱
  static Future<Pager<List<EmojiModel>>?> getEmojiList({
    int page = 1,
    int pageSize = 20,
  }) async {
    final res = await hpHttp.get<dynamic>(
      '/api/emoji',
      queryParameters: {
        'page': page,
        'page_size': pageSize,
      },
    );
    return res.data == null
        ? null
        : Pager.fromJson(
            res.data as Map<String, dynamic>,
            (json) => json == null
                ? <EmojiModel>[]
                : List<EmojiModel>.from(
                    (json as Iterable).map(
                      (x) => EmojiModel.fromJson(x as Map<String, dynamic>),
                    ),
                  ),
          );
  }

  /// 新增小德表情包🐱
  static Future<EmojiModel?> addEmoji({
    required String image,
    String? text,
    String? color,
  }) async {
    final res = await hpHttp.post<dynamic>(
      '/api/emoji',
      data: {
        'image': image,
        'text': text,
        'color': color,
      },
    );
    return res.data == null
        ? null
        : EmojiModel.fromJson(res.data as Map<String, dynamic>);
  }

  /// 批量新增小德表情包🐱
  static Future<void> multiAddEmoji(List<EmojiParam> emojis) async {
    await hpHttp.post<dynamic>(
      '/api/emoji/all',
      data: emojis.map((emoji) => emoji.toJson()).toList(),
    );
  }
}
