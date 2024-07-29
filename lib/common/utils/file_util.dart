// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:pigeon/common/utils/string_util.dart';

class FileUtil {
  static String folder = 'expert-planet';

  static Future<String> get _localPath async {
    final directory = defaultTargetPlatform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return StringUtil.getValue(directory?.path);
  }

  static Future<File> localFile(String fileName) async {
    final path = await _localPath;
    return File(
        '$path${Platform.pathSeparator}$folder${Platform.pathSeparator}$fileName',);
  }

  static Future<List<int>> readFile(String fileName) async {
    try {
      final file = await localFile(fileName);
      return await file.readAsBytes();
    } catch (e) {
      return <int>[];
    }
  }

  static Future<File> writeFile(List<int> content, String fileName) async {
    final file = await localFile(fileName);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file.writeAsBytes(content);
  }
}
