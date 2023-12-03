import 'dart:async';

import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/http/hp_http.dart';
import 'package:homing_pigeon/common/models/models.dart';

class UploadApi {
  /// 文件上传
  static Future<List<FileModel>> uploadFile(List<List<int>> files) async {
    try {
      final res = await hpHttp.post<dynamic>(
        '/api/backend/upload/',
        data: FormData.fromMap({
          'files': files.map(MultipartFile.fromBytes).toList(),
        }),
        options: Options(
          headers: {
            'Accept': '*/*',
            'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8',
          },
        ),
      );
      return res.data == null
          ? []
          : List<FileModel>.from(
              (res.data as Iterable).map(
                (x) => FileModel.fromJson(x as Map<String, dynamic>),
              ),
            );
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }
}
