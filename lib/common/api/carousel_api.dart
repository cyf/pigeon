import 'dart:async';

import 'package:pigeon/common/http/hp_http.dart';
import 'package:pigeon/common/models/models.dart';

class CarouselApi {
  /// 轮播图
  static Future<List<CarouselModel>> getCarouselList() async {
    final res = await hpHttp.get<dynamic>('/api/carousel');
    return res.data == null
        ? []
        : List<CarouselModel>.from(
            (res.data as Iterable).map(
              (x) => CarouselModel.fromJson(x as Map<String, dynamic>),
            ),
          );
  }
}
