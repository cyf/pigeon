import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:git/git.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;

/// {@template ios_command}
///
/// `ios_command sample`
/// A [Command] to exemplify a sub command
/// {@endtemplate}
const iosConfigPath = 'ios/Flutter/BuildConfig.xcconfig';

class IOSCommand extends Command<int> {
  /// {@macro ios_command}
  IOSCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser.addOption(
      'env',
      abbr: 'e',
      allowed: ['development', 'staging', 'production'],
      defaultsTo: 'development',
      help: '基于哪个环境进行构建',
    );
  }

  @override
  String get description => '对iOS包进行预构建';

  @override
  String get name => 'ios';

  final Logger _logger;

  @override
  Future<int> run() async {
    final output = description;
    final env = argResults?['env'] as String?;
    _logger
      ..info(lightBlue.wrap(output))
      ..info('当前工作空间: ${path.current}')
      ..info('当前环境: ${lightRed.wrap(env) ?? ""}');
    if (await GitDir.isGitDir(path.current)) {
      final gitDir = await GitDir.fromExisting(path.current);
      final result = await gitDir.runCommand(
        ['rev-parse', '--short=8', 'HEAD'],
        throwOnError: false,
      );
      if (result.exitCode != 0) {
        _logger.err(
          'exitCode: ${result.exitCode}, stderr: ${result.stderr as String?}',
        );
        return result.exitCode;
      }
      final stdout = result.stdout as String?;
      final gitCommit = stdout?.trim();
      _logger.info('当前提交: ${lightRed.wrap(gitCommit)}');

      final baseConfigFile = File(iosConfigPath);
      if (baseConfigFile.existsSync()) {
        _logger.warn('File $iosConfigPath is deleted.');
        baseConfigFile.deleteSync();
        // final content = baseConfigFile.readAsStringSync();
        // _logger.info(content);
      }
      _logger.warn('File $iosConfigPath is created.');
      baseConfigFile
        ..createSync()
        ..writeAsStringSync('FLUTTER_BUILD_ENV=+$env');
      if (gitCommit != null && gitCommit.isNotEmpty) {
        baseConfigFile.writeAsStringSync(
          '\nFLUTTER_BUILD_NAME_SUFFIX=-$gitCommit',
          mode: FileMode.append,
        );
      }
    }
    return ExitCode.success.code;
  }
}
