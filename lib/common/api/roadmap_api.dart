import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/http/hp_http.dart';
import 'package:homing_pigeon/common/models/models.dart';

class RoadmapApi {
  /// 获取路线图
  static Future<List<RoadmapModel>> getRoadmapList({
    required int year,
    required int month,
  }) async {
    try {
      final res = await hpHttp.get<dynamic>(
        '/api/backend/roadmap/list/',
        queryParameters: {
          'year': year,
          'month': month,
        },
      );
      return res.data == null
          ? []
          : List<RoadmapModel>.from(
              (res.data as Iterable).map(
                (x) => RoadmapModel.fromJson(x as Map<String, dynamic>),
              ),
            );
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }
}
