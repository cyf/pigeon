import 'dart:io';

import 'package:args/args.dart';

const flavorArgName = 'flavor';
const buildModeArgName = 'mode';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption(
      flavorArgName,
      abbr: 'f',
      allowed: ['external', 'internal'],
      defaultsTo: 'internal',
      help: 'flavor名字',
    )
    ..addOption(
      buildModeArgName,
      abbr: 'm',
      allowed: ['debug', 'release'],
      defaultsTo: 'debug',
      help: '目标环境',
    );

  final argResults = parser.parse(arguments);
  final flavor = argResults[flavorArgName] as String;
  final buildMode = argResults[buildModeArgName] as String;

  final commonConfigFile = File('ios/Flutter/Common.xcconfig');
  if (commonConfigFile.existsSync()) {
    commonConfigFile.deleteSync();
  }
  commonConfigFile..createSync(recursive: true)
  ..writeAsStringSync(genConfigContent(flavor, buildMode));
}

String genConfigContent(
  String flavor,
  String buildMode,
) =>
    '''
#include? "Pods/Target Support Files/Pods-$flavor/Pods-$flavor.$buildMode.xcconfig"
''';
