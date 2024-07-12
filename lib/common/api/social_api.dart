import 'dart:async';

import 'package:pigeon/common/http/hp_http.dart';
import 'package:pigeon/common/models/models.dart';

class SocialApi {
  /// 直播信息/提醒群
  static Future<Pager<List<SocialModel>>?> getSocialCardList({
    int page = 1,
    int pageSize = 20,
  }) async {
    final res = await hpHttp.get<dynamic>(
      '/api/social',
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
                ? <SocialModel>[]
                : List<SocialModel>.from(
                    (json as Iterable).map(
                      (x) => SocialModel.fromJson(x as Map<String, dynamic>),
                    ),
                  ),
          );
  }
}
