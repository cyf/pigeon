# Homing Pigeon

[![Test](https://github.com/cyf/homing_pigeon/actions/workflows/test.yml/badge.svg)](https://github.com/cyf/homing_pigeon/actions/workflows/test.yml)
[![Release](https://github.com/cyf/homing_pigeon/actions/workflows/release.yml/badge.svg)](https://github.com/cyf/homing_pigeon/actions/workflows/release.yml)
[![Release to GitHub](https://github.com/cyf/homing_pigeon/actions/workflows/release-github.yml/badge.svg)](https://github.com/cyf/homing_pigeon/actions/workflows/release-github.yml)

## iOS

```shell
# 导入证书
security import ./<name>.cer -P <password> -A -t cert

# 导入.p12私钥
security import ./<name>.p12 -P <password> -A -t cert -f pkcs12

# 双击导入mobileprovision文件
```
