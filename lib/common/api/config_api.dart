import 'dart:async';

import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/http/hp_http.dart';
import 'package:homing_pigeon/common/models/models.dart';

class ConfigApi {
  /// 全局配置
  static Future<List<ConfigModel>> getConfigList() async {
    try {
      final res = await hpHttp.get<dynamic>('/api/backend/config');
      return res.data == null
          ? []
          : List<ConfigModel>.from(
              (res.data as Iterable).map(
                (x) => ConfigModel.fromJson(x as Map<String, dynamic>),
              ),
            );
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }
}
