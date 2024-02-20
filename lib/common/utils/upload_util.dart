import 'dart:async';
import 'dart:io';

import 'package:flutter_aliyun_oss/flutter_aliyun_oss.dart';
import 'package:homing_pigeon/app/config.dart';
import 'package:homing_pigeon/common/constants/constants.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:minio_flutter/minio.dart';
import 'package:path/path.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UploadUtil {
  static Future<FileModel?> upload({
    required FileWrapper fileWrapper,
    String dir = 'homing-pigeon-mobile/',
  }) async {
    if (Constants.ossEnabled) {
      if (AppConfig.shared.isExternal) {
        return uploadAwsS3(fileWrapper: fileWrapper, dir: dir);
      } else if (AppConfig.shared.isInternal) {
        return uploadOSS(fileWrapper: fileWrapper, dir: dir);
      }
    }
    return null;
  }

  static Future<FileModel> uploadOSS({
    required FileWrapper fileWrapper,
    String dir = 'homing-pigeon-mobile/',
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final location = tz.getLocation('Asia/Shanghai');
    final beijingTimeStamp = tz.TZDateTime.now(location);
    final beijingTime = DateFormat('yyyy-MM-dd').format(beijingTimeStamp);
    final newFileName = '${now}_${fileWrapper.name}';
    final uuid = basenameWithoutExtension(newFileName);
    final ext = extension(newFileName);
    final path = '$dir$beijingTime';

    // 获取文件类型
    final type = StringUtil.getValue(lookupMimeType(fileWrapper.file.path));
    await OSSClient.shared.putObject(
      object: OSSImageObject.fromFile(file: fileWrapper.file, uuid: uuid),
      path: path,
    );
    return FileModel(
      oldFileName: fileWrapper.name,
      fileSize: fileWrapper.file.lengthSync(),
      type: type,
      url: '${Constants.host}/$path/$uuid${ext.toLowerCase()}',
      name: newFileName,
    );
  }

  static Future<FileModel> uploadAwsS3({
    required FileWrapper fileWrapper,
    String dir = 'homing-pigeon-mobile/',
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final location = tz.getLocation('Asia/Shanghai');
    final beijingTimeStamp = tz.TZDateTime.now(location);
    final beijingTime = DateFormat('yyyy-MM-dd').format(beijingTimeStamp);
    final newFileName = '${now}_${fileWrapper.name}';
    final path = '$dir$beijingTime/$newFileName';

    // 获取文件类型
    final type = StringUtil.getValue(lookupMimeType(fileWrapper.file.path));
    await Minio.shared.putObject(
      Constants.bucket,
      path,
      fileWrapper.file.readAsBytes().asStream(),
    );

    return FileModel(
      oldFileName: fileWrapper.name,
      fileSize: fileWrapper.file.lengthSync(),
      type: type,
      url: '${Constants.host}/$path',
      name: newFileName,
    );
  }
}

class FileWrapper {
  const FileWrapper({
    required this.asset,
    required this.file,
    required this.name,
  });

  final AssetEntity asset;
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
