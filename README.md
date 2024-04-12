# Homing Pigeon

[![Test](https://github.com/cyf/homing-pigeon/actions/workflows/test.yml/badge.svg)](https://github.com/cyf/homing-pigeon/actions/workflows/test.yml)
[![Release to GitHub](https://github.com/cyf/homing-pigeon/actions/workflows/release-github.yml/badge.svg)](https://github.com/cyf/homing-pigeon/actions/workflows/release-github.yml)

## Requirements

### iOS

1. 导入证书
```shell
security import ./<name>.cer -P <password> -A -t cert
```

2. 导入.p12私钥
```shell
security import ./<name>.p12 -P <password> -A -t cert -f pkcs12
```

3. 双击导入mobileprovision文件
4. 手动安装模拟器运行时
- 已安装列表
```shell
xcrun simctl runtime list
```

- 安装
```shell
xcrun simctl runtime add "~/iOS_17.0.1_Simulator_Runtime.dmg"
```

### Android

## Release

app打包发生变化，这样发布到蒲公英的版本号，会带有commit信息，方便排查；发布到Google play或app store的版本号和之前一个样。

以下脚本都在`Makefile`文件下，JetBrains / Android Studio可能需要安装`Makefile Language`插件。

### Flutter

>在`pubspec.yaml`文件修改`version: <new version>`

### Android

>如果发布到生产环境, 请在`android/app/build.gradle`文件修改`versionCode`

#### 国内渠道

- 如果发布到测试环境, 运行
```shell
make ENV=<development|staging|production> internal_apk
```

- 如果发布到生产环境, 运行
```shell
make internal_appbundle
```

#### 国外渠道

- 如果发布到测试环境, 运行
```shell
make ENV=<development|staging|production> external_apk
```

- 如果发布到生产环境, 运行
```shell
make external_appbundle
```

### iOS

>如果发布到生产环境, 请修改`build`号

#### 国内渠道

- 如果发布到测试环境, 运行
```shell
make ENV=<development|staging|production> internal_adhoc
```

- 如果发布到生产环境, 运行
```shell
make internal_appstore
```

#### 国外渠道

- 如果发布到测试环境, 运行
```shell
make ENV=<development|staging|production> external_adhoc
```

- 如果发布到生产环境, 运行
```shell
make external_appstore
```

## Tests

### 极光推送测试

Android点击通知打开

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
adb shell am start -a android.intent.action.VIEW -d "hp://debug"
```

#### Custom URL schemes on iOS

```shell
/usr/bin/xcrun simctl openurl booted "hp://debug"
```
