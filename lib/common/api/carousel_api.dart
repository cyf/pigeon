import 'dart:async';

import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/http/hp_http.dart';
import 'package:homing_pigeon/common/models/models.dart';

class CarouselApi {
  /// 轮播图
  static Future<List<CarouselModel>> getCarouselList() async {
    try {
      final res = await hpHttp.get<dynamic>('/api/backend/carousel/list/');
      return res.data == null
          ? []
          : List<CarouselModel>.from(
              (res.data as Iterable).map(
                (x) => CarouselModel.fromJson(x as Map<String, dynamic>),
              ),
            );
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }
}
