import 'dart:developer';

import 'package:version/version.dart';

class VersionUtil {
  static final ios14 = Version(14, 0, 0);

  static Version tryParse(String versionString) {
    try {
      return Version.parse(versionString);
    } on Exception catch (error) {
      log('[Version parsing error]: $error');
    }
    return Version(0, 0, 0);
  }
}
