# Homing Pigeon

[![Test](https://github.com/cyf/homing_pigeon/actions/workflows/test.yml/badge.svg)](https://github.com/cyf/homing_pigeon/actions/workflows/test.yml)
[![Release to GitHub](https://github.com/cyf/homing_pigeon/actions/workflows/release-github.yml/badge.svg)](https://github.com/cyf/homing_pigeon/actions/workflows/release-github.yml)

## 极光推送测试

> Android点击通知打开

### debug on android

`intent:#Intent;action=com.chenyifaer.homingpigeon.dev/com.kjxbyz.plugins.jpush.OpenClickActivity;component=com.chenyifaer.homingpigeon.dev/com.kjxbyz.plugins.jpush.OpenClickActivity;end`

### release on android

`intent:#Intent;action=com.chenyifaer.homingpigeon/com.kjxbyz.plugins.jpush.OpenClickActivity;component=com.chenyifaer.homingpigeon/com.kjxbyz.plugins.jpush.OpenClickActivity;end`

## tests for app_links

### Deep Links on Android

adb shell am start -a android.intent.action.VIEW -d "hp://debug"

### Custom URL schemes on iOS

/usr/bin/xcrun simctl openurl booted "hp://debug"

## iOS

```shell
# 导入证书
security import ./<name>.cer -P <password> -A -t cert

# 导入.p12私钥
security import ./<name>.p12 -P <password> -A -t cert -f pkcs12

# 双击导入mobileprovision文件
```

> 手动安装模拟器运行时

```shell

# 已安装列表
xcrun simctl runtime list

# 安装
xcrun simctl runtime add "~/iOS_17.0.1_Simulator_Runtime.dmg"
```
