import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/api/upload_api.dart';
import 'package:homing_pigeon/common/constants/keys.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/http/hp_http.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/sp_util.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:timezone/timezone.dart' as tz;

class UploadUtil {
  static Future<FileModel> uploadFile({
    required FileWrapper fileWrapper,
    String dir = 'homing-pigeon-mobile/',
  }) async {
    final postPolicy = await loadOssParams();
    if (postPolicy == null) {
      throw const RequestedException('Bad request');
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    final location = tz.getLocation('Asia/Shanghai');
    final beijingTimeStamp = tz.TZDateTime.now(location);
    final beijingTime = DateFormat('yyyy-MM-dd').format(beijingTimeStamp);
    final newFileName = '${now}_${fileWrapper.name}';
    final key =
        '${StringUtil.isNotBlank(postPolicy.dir) ? '${postPolicy.dir}/' : ''}$dir$beijingTime/$newFileName';
    if (StringUtil.isBlank(postPolicy.host) ||
        StringUtil.isBlank(postPolicy.accessId) ||
        StringUtil.isBlank(postPolicy.policy) ||
        StringUtil.isBlank(postPolicy.signature)) {
      throw const RequestedException('Bad request');
    }

    final baseUrl = postPolicy.host!;
    final accessKeyId = postPolicy.accessId!;
    final policy = postPolicy.policy!;
    final signature = postPolicy.signature!;

    await UploadApi.uploadOSS(
      url: baseUrl,
      key: key,
      accessKeyId: accessKeyId,
      policy: policy,
      signature: signature,
      file: fileWrapper.file.readAsBytesSync(),
    );
    final url = '$baseUrl/$key';
    // 获取文件类型
    final type = StringUtil.getValue(lookupMimeType(fileWrapper.file.path));
    return FileModel(
      oldFileName: fileWrapper.name,
      fileSize: fileWrapper.file.lengthSync(),
      type: type,
      url: url,
      name: newFileName,
    );
  }

  static Future<PostPolicy?> loadOssParams() async {
    final postPolicyValue = SpUtil.getString(Keys.postPolicyKey);
    if (StringUtil.isNotBlank(postPolicyValue)) {
      final postPolicy = PostPolicy.fromJson(
        json.decode(postPolicyValue) as Map<String, dynamic>,
      );
      final expire = postPolicy.expire ?? 0;
      if (DateTime.now().millisecondsSinceEpoch > expire * 1000) {
        return fetchPostPolicy();
      }
      return postPolicy;
    } else {
      return fetchPostPolicy();
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

class FileWrapper {
  const FileWrapper({
    required this.file,
    required this.name,
  });

  final File file;
  final String name;
}

class FileModel {
  const FileModel({
    required this.oldFileName,
    required this.fileSize,
    required this.type,
    required this.url,
    required this.name,
  });

  final String oldFileName;
  final int fileSize;
  final String type;
  final String url;
  final String name;
}
