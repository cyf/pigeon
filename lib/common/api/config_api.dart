// Dart imports:
import 'dart:async';

// Project imports:
import 'package:pigeon/common/http/hp_http.dart';
import 'package:pigeon/common/models/models.dart';

class ConfigApi {
  /// 全局配置
  static Future<List<ConfigModel>> getConfigList() async {
    final res = await hpHttp.get<dynamic>('/api/config');
    return res.data == null
        ? []
        : List<ConfigModel>.from(
            (res.data as Iterable).map(
              (x) => ConfigModel.fromJson(x as Map<String, dynamic>),
            ),
          );
  }
}
