import 'dart:async';

import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/http/hp_http.dart';
import 'package:homing_pigeon/common/models/models.dart';

class SocialApi {
  /// 直播信息/提醒群
  static Future<List<CardItem>> getSocialCardList() async {
    try {
      final res = await hpHttp.get<dynamic>('/api/backend/social/list/');
      return res.data == null
          ? []
          : List<CardItem>.from(
              (res.data as Iterable).map(
                (x) => CardItem.fromJson(x as Map<String, dynamic>),
              ),
            );
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }
}
