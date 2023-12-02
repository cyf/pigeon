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
}
