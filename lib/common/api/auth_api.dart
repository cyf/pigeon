import 'package:dio/dio.dart';
import 'package:homing_pigeon/common/exception/exception.dart';
import 'package:homing_pigeon/common/http/hp_http.dart';
import 'package:homing_pigeon/common/models/models.dart';
import 'package:homing_pigeon/common/utils/string_util.dart';

class AuthApi {
  /// 登录
  static Future<TokenModel?> login({
    required String account,
    required String password,
  }) async {
    try {
      final res = await hpHttp.post<dynamic>(
        '/api/backend/auth/login',
        data: {
          'account': account,
          'password': password,
        },
      );
      return res.data == null
          ? null
          : TokenModel.fromJson(res.data as Map<String, dynamic>);
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }

  /// 注册
  static Future<TokenModel?> register({
    required String username,
    required String password,
    required String email,
    String? nickname,
  }) async {
    try {
      final res = await hpHttp.post<dynamic>(
        '/api/backend/auth/register',
        data: {
          'username': username,
          'password': password,
          'email': email,
          'nickname': StringUtil.getValue(nickname, defaultVal: username),
        },
      );
      return res.data == null
          ? null
          : TokenModel.fromJson(res.data as Map<String, dynamic>);
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }

  /// 登录
  static Future<UserModel?> profile() async {
    try {
      final res = await hpHttp.get<dynamic>(
        '/api/backend/auth/profile',
      );
      return res.data == null
          ? null
          : UserModel.fromJson(res.data as Map<String, dynamic>);
    } on Exception catch (error) {
      throw RequestedException(
        error is DioException ? error.error : error.toString(),
      );
    }
  }
}
