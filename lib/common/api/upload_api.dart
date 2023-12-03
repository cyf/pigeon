import 'dart:async';

import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/http/hp_http.dart';
import 'package:homing_pigeon/common/models/models.dart';

class UploadApi {
  /// 文件上传
  static Future<FileModel?> uploadFile({
    required List<int> file,
    String? filename,
  }) async {
    try {
      final res = await hpHttp.post<dynamic>(
        '/api/backend/upload/',
        data: FormData.fromMap({
          'file': MultipartFile.fromBytes(file),
          'filename': filename,
        }),
        options: Options(
          headers: {
            'Accept': '*/*',
            'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8',
          },
        ),
      );
      return res.data == null
          ? null
          : FileModel.fromJson(res.data as Map<String, dynamic>);
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }
}
