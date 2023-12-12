#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dxcaptcha_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'dxcaptcha_flutter'
  s.version          = '0.0.1'
  s.summary          = 'Dx Captcha for Flutter.'
  s.description      = <<-DESC
Enables Dx Captcha in Flutter apps.
                       DESC
  s.homepage         = 'https://kjxbyz.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'kjxbyz' => 'kjxbyz@163.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.{h,m,swift}'
  s.public_header_files = 'Classes/**/*.h'
  s.module_map = 'Classes/DxCaptchaFlutterPlugin.modulemap'
  s.static_framework = true
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  s.ios.deployment_target = '11.0'
  s.swift_version  = '5.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }

  # 这个会添加到最终target 的xcconfig中，不建议使用，不应该污染用户项目的构建设置，因为这可能导致冲突。
  # 解决OC与Swift混编的问题
  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

  # https://github.com/CocoaPods/CocoaPods/issues/3232
  s.ios.libraries = 'c++', 'c++abi', 'resolv.9', 'z'
  s.ios.frameworks = 'CoreLocation', 'CoreTelephony', 'SystemConfiguration'

#   s.preserve_paths = 'Frameworks/DXRiskStaticWithIDFA.framework/**/*', 'Frameworks/DingxiangCaptchaSDKStatic.framework/**/*'
  s.resources = ['Resources/DXCaptcha.bundle']
  s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC -framework DXRiskStaticWithIDFA -framework DingxiangCaptchaSDKStatic' }
  s.vendored_frameworks = 'Frameworks/DXRiskStaticWithIDFA.framework', 'Frameworks/DingxiangCaptchaSDKStatic.framework'
end
