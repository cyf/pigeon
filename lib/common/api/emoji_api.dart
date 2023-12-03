import 'dart:async';

import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/http/hp_http.dart';
import 'package:homing_pigeon/common/models/models.dart';

class EmojiApi {
  /// 小德表情包🐱
  static Future<Pager<List<EmojiModel>>?> getEmojiList({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final res = await hpHttp.get<dynamic>(
        '/api/backend/emoji/list/',
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
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }

  /// 新增小德表情包🐱
  static Future<EmojiModel?> addEmoji({
    required String image,
    String? text,
    String? color,
  }) async {
    try {
      final res = await hpHttp.post<dynamic>(
        '/api/backend/emoji/add/',
        data: {
          'image': image,
          'text': text,
          'color': color,
        },
      );
      return res.data == null
          ? null
          : EmojiModel.fromJson(res.data as Map<String, dynamic>);
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }

  /// 批量新增小德表情包🐱
  static Future<void> multiAddEmoji(List<EmojiModel> emojis) async {
    try {
      await hpHttp.post<dynamic>(
        '/api/backend/emoji/multi-add/',
        data: emojis
            .map(
              (emoji) => {
                'image': emoji.image,
                'text': emoji.text,
              },
            )
            .toList(),
      );
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }
}
