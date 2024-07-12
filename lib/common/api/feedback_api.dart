import 'dart:async';

import 'package:pigeon/common/http/hp_http.dart';
import 'package:pigeon/common/models/models.dart';

class FeedbackApi {
  /// 反馈列表
  static Future<Pager<List<FeedbackModel>>?> getFeedbackList({
    int page = 1,
    int pageSize = 10,
  }) async {
    final res = await hpHttp.get<dynamic>(
      '/api/feedback',
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
                ? <FeedbackModel>[]
                : List<FeedbackModel>.from(
                    (json as Iterable).map(
                      (x) => FeedbackModel.fromJson(x as Map<String, dynamic>),
                    ),
                  ),
          );
  }

  /// 反馈详情
  static Future<FeedbackModel?> getFeedbackDetail({
    required String id,
  }) async {
    final res = await hpHttp.get<dynamic>(
      '/api/feedback/$id',
    );
    return res.data == null
        ? null
        : FeedbackModel.fromJson(res.data as Map<String, dynamic>);
  }

  /// 新增反馈
  static Future<FeedbackModel?> addFeedback({
    required String title,
    required String description,
    List<Map<String, dynamic>>? files,
  }) async {
    final res = await hpHttp.post<dynamic>(
      '/api/feedback',
      data: {
        'title': title,
        'description': description,
        'files': files,
      },
    );
    return res.data == null
        ? null
        : FeedbackModel.fromJson(res.data as Map<String, dynamic>);
  }
}
