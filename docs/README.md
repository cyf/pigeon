# Development

## Requirements

### iOS

```shell
# 1. 导入证书
security import ./<name>.cer -P <password> -A -t cert

# 2. 导入.p12私钥
security import ./<name>.p12 -P <password> -A -t cert -f pkcs12

# 3. 双击导入mobileprovision文件
```

```shell
# 手动安装模拟器运行时
# 已安装列表
xcrun simctl runtime list

# 安装
xcrun simctl runtime add "~/iOS_17.0.1_Simulator_Runtime.dmg"
```

## Release

### Flutter

>在`pubspec.yaml`文件修改`version: <new version>`

### Android

#### 国内渠道

```shell
# 如果发布到测试环境
make ENV=<dev|stg|prod> internal_apk
```

```shell
# 如果发布到生产环境
make internal_appbundle
```

#### 国外渠道

```shell
# 如果发布到测试环境
make ENV=<dev|stg|prod> external_apk
```

```shell
# 如果发布到生产环境
make external_appbundle
```

### iOS

#### 国内渠道

```shell
# 如果发布到测试环境
make ENV=<dev|stg|prod> internal_adhoc
```

```shell
# 如果发布到生产环境
make internal_appstore
```

#### 国外渠道

```shell
# 如果发布到测试环境
make ENV=<dev|stg|prod> external_adhoc
```

```shell
# 如果发布到生产环境
make external_appstore
```

## Tests

### 极光推送测试

>Android点击通知打开

#### Debug on Android

```text
intent:#Intent;action=com.chenyifaer.homingpigeon.dev/com.kjxbyz.plugins.jpush.OpenClickActivity;component=com.chenyifaer.homingpigeon.dev/com.kjxbyz.plugins.jpush.OpenClickActivity;end
```

#### Release on Android

```text
intent:#Intent;action=com.chenyifaer.homingpigeon/com.kjxbyz.plugins.jpush.OpenClickActivity;component=com.chenyifaer.homingpigeon/com.kjxbyz.plugins.jpush.OpenClickActivity;end
```

### app links

#### Deep Links on Android

```shell
adb shell am start -a android.intent.action.VIEW -d "pigeon://debug"
```

#### Custom URL schemes on iOS

```shell
/usr/bin/xcrun simctl openurl booted "pigeon://debug"
```
