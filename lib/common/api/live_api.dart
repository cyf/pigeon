// Project imports:
import 'package:pigeon/common/enums/enums.dart';
import 'package:pigeon/common/http/yt_http.dart';
import 'package:pigeon/common/models/models.dart';

class LiveApi {
  /// 获取直播
  static Future<YTResponse<List<YTVideoModel>>?> getVideoList({
    EventType eventType = EventType.live,
  }) async {
    final res = await ytHttp.get<dynamic>(
      '/youtube/v3/search',
      queryParameters: {
        'part': 'id,snippet',
        'channelId': 'UC7QVieoTCNwwW84G0bddXpA',
        'channelType': 'any',
        'eventType': eventType.name,
        'type': 'video',
        'maxResults': 10,
      },
    );
    return res.data == null
        ? null
        : YTResponse.fromJson(
            res.data as Map<String, dynamic>,
            (json) => json == null
                ? <YTVideoModel>[]
                : List<YTVideoModel>.from(
                    (json as Iterable).map(
                      (x) => YTVideoModel.fromJson(x as Map<String, dynamic>),
                    ),
                  ),
          );
  }

}
