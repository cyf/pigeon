import 'package:pigeon/common/http/hp_http.dart';
import 'package:pigeon/common/models/models.dart';
import 'package:pigeon/common/utils/string_util.dart';

class AuthApi {
  /// 登录
  static Future<TokenModel?> login({
    required String account,
    required String password,
  }) async {
    final res = await hpHttp.post<dynamic>(
      '/api/auth/login',
      data: {
        'account': account,
        'password': password,
      },
    );
    return res.data == null
        ? null
        : TokenModel.fromJson(res.data as Map<String, dynamic>);
  }

  /// 注册
  static Future<TokenModel?> register({
    required String username,
    required String password,
    required String email,
    String? nickname,
  }) async {
    final res = await hpHttp.post<dynamic>(
      '/api/auth/register',
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
  }

  /// 登录
  static Future<UserModel?> profile() async {
    final res = await hpHttp.get<dynamic>(
      '/api/auth/profile',
    );
    return res.data == null
        ? null
        : UserModel.fromJson(res.data as Map<String, dynamic>);
  }
}
