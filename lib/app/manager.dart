class AppManager {
  /// 私有构造器
  AppManager._();

  /// 版本号
  String? version;

  /// 构建版本
  String? buildNumber;

  bool jPushInitialized = false;

  bool firebaseInitialized = false;

  /// 静态变量指向自身
  static final AppManager _instance = AppManager._();

  /// 静态属性获得实例变量
  static AppManager get instance => _instance;
}
