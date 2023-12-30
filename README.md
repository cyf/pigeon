# Homing Pigeon

[![Codemagic build status](https://api.codemagic.io/apps/655631d92ac9fd34cfac931c/655631d92ac9fd34cfac931b/status_badge.svg)](https://codemagic.io/apps/655631d92ac9fd34cfac931c/655631d92ac9fd34cfac931b/latest_build)

## iOS

```shell
# 导入证书
security import ./<name>.cer -P <password> -A -t cert

# 导入.p12私钥
security import ./<name>.p12 -P <password> -A -t cert -f pkcs12

# 双击导入mobileprovision文件
```
