import 'dart:async';
import 'dart:io';

import 'package:aliyun_oss_flutter/aliyun_oss_flutter.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:timezone/timezone.dart' as tz;

class UploadUtil {
  static Future<FileModel> uploadOSS({
    required FileWrapper fileWrapper,
    String dir = 'homing-pigeon-mobile/',
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final location = tz.getLocation('Asia/Shanghai');
    final beijingTimeStamp = tz.TZDateTime.now(location);
    final beijingTime = DateFormat('yyyy-MM-dd').format(beijingTimeStamp);
    final newFileName = '${now}_${fileWrapper.name}';
    final path = '$dir$beijingTime/$newFileName';
    final url = '${Constants.host}/$path';

    // 获取文件类型
    final type = StringUtil.getValue(lookupMimeType(fileWrapper.file.path));
    await OSSClient().putObject(
      object: OSSImageObject.fromFile(file: fileWrapper.file),
      path: path,
    );
    return FileModel(
      oldFileName: fileWrapper.name,
      fileSize: fileWrapper.file.lengthSync(),
      type: type,
      url: url,
      name: newFileName,
    );
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
