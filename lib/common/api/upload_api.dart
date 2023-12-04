import 'dart:async';

import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/http/hp_http.dart';
import 'package:homing_pigeon/common/http/upload_http.dart';
import 'package:homing_pigeon/common/models/models.dart';

class UploadApi {
  /// 文件上传
  static Future<void> uploadOSS({
    required String url,
    required String key,
    required String accessKeyId,
    required String policy,
    required String signature,
    required List<int> file,
  }) async {
    try {
      await uploadHttp.post<dynamic>(
        url,
        data: FormData.fromMap({
          'key': key,
          'OSSAccessKeyId': accessKeyId,
          'policy': policy,
          'Signature': signature,
          'file': MultipartFile.fromBytes(file),
        }),
      );
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }

  static Future<PostPolicy?> fetchPostPolicy() async {
    try {
      final res = await hpHttp.get<dynamic>(
        '/api/backend/policy/',
      );
      return res.data == null
          ? null
          : PostPolicy.fromJson(res.data as Map<String, dynamic>);
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }
}
