#import "HCaptchaFlutterPlugin.h"

@interface HCaptchaFlutterPlugin () <UIGestureRecognizerDelegate>

@property(strong, readonly) FlutterMethodChannel *channel;
@property(strong) NSDictionary *launchOptions;
@property(strong, nonatomic) HCaptcha *hCaptcha;
@property(strong, nonatomic) UIView *overlayView;
@property(weak, nonatomic) WKWebView *webView;

@end

@implementation HCaptchaFlutterPlugin
- (instancetype)initWithChannel:(FlutterMethodChannel *)channel {
    self = [super init];
    if (self) {
      _channel = channel;
    }
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"plugins.kjxbyz.com/hcaptcha_flutter_plugin"
            binaryMessenger:[registrar messenger]];
  HCaptchaFlutterPlugin* instance = [[HCaptchaFlutterPlugin alloc] initWithChannel: channel];
  [registrar addApplicationDelegate:instance];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"show" isEqualToString:call.method]) {
    id arguments = call.arguments;
    if (arguments == nil) {
      NSLog(@"hCaptcha配置为空");
      return;
    }

    if (![arguments isKindOfClass: NSMutableDictionary.class]) {
      NSLog(@"hCaptcha配置必须为字典类型");
      return;
    }

    NSMutableDictionary *config = (NSMutableDictionary *) arguments;
    id siteKey = [config objectForKey:@"siteKey"];
    id language = [config objectForKey:@"language"];
    if (siteKey == nil || [@"" isEqualToString:siteKey]) {
      NSLog(@"hCaptcha验证码配置中siteKey字段为空");
      return;
    }

    if (language == nil || [@"" isEqualToString:language]) {
      NSLog(@"hCaptcha验证码配置中language字段为空");
      language = @"en";
    }

    if (self.hCaptcha == nil) {
      self.hCaptcha = [[HCaptcha alloc] initWithApiKey: siteKey
                                             baseURL: [NSURL URLWithString: @"http://localhost"]
                                             locale: [NSLocale localeWithLocaleIdentifier: language]
                                             size: HCaptchaSizeInvisible
                                             error: nil];
    }

    UIViewController* viewController = [self topViewController];
    UIView* view = viewController.view;

    // tap
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];

    // overlay
    self.overlayView = [[UIView alloc] init];
    self.overlayView.frame = view.bounds;
    self.overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.overlayView addGestureRecognizer:gestureRecognizer];
    [view addSubview:self.overlayView];

    // loading view
    UIView* loadingView = [[UIView alloc] init];
    loadingView.frame = CGRectMake(0, 0, 80, 80);
    loadingView.center = self.overlayView.center;
    loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    loadingView.clipsToBounds = true;
    loadingView.layer.cornerRadius = 10;

    // loading indicator
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] init];
    activityIndicator.frame = CGRectMake(0, 0, 40, 40);
    activityIndicator.center = CGPointMake(loadingView.frame.size.width / 2,
                                           loadingView.frame.size.height / 2);
    activityIndicator.hidesWhenStopped = YES;
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;

    [loadingView addSubview:activityIndicator];
    [self.overlayView addSubview:loadingView];
    [activityIndicator startAnimating];

    [self.hCaptcha configureWebView:^(WKWebView * _Nonnull webView) {
      CGFloat width = view.bounds.size.width;
      CGFloat height = view.bounds.size.height;
      CGFloat webviewWidth = 325;
      CGFloat webviewHeight = 490;
      webView.frame = CGRectMake((width - webviewWidth)/2, (height - webviewHeight)/2, webviewWidth, webviewHeight);
      self.webView = webView;
    }];

    [self.hCaptcha onEvent:^(enum HCaptchaEvent event, id _Nullable _) {
      NSLog(@"event: %ld", event);
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (event == HCaptchaEventOpen) {
          [activityIndicator stopAnimating];
          [self.channel invokeMethod: @"open" arguments: nil];
        } else if (event == HCaptchaEventError) {
          [activityIndicator stopAnimating];
          [self.channel invokeMethod: @"error" arguments: nil];
        }
      });
    }];

    [self.hCaptcha validateOn:view resetOnError:NO completion:^(HCaptchaResult *result) {
      NSError *error = nil;
      NSString *token = [result dematerializeAndReturnError: &error];
      NSLog(@"DONE token:%@, error:%@", token, [error description]);
      if (error == nil) {
        [self.hCaptcha reset];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject: token forKey: @"token"];
        NSData *data;
        if (@available(iOS 13.0, *)) {
          data = [NSJSONSerialization dataWithJSONObject:dict options: NSJSONWritingWithoutEscapingSlashes error:nil];
        } else {
          // Fallback on earlier versions
          data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        }
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self.channel invokeMethod: @"success" arguments: response];
      } else {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject: [error description] forKey: @"error"];
        NSData *data;
        if (@available(iOS 13.0, *)) {
          data = [NSJSONSerialization dataWithJSONObject:dict options: NSJSONWritingWithoutEscapingSlashes error:nil];
        } else {
          // Fallback on earlier versions
          data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        }
        NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self.channel invokeMethod: @"error" arguments: response];
      }

      [self.webView removeFromSuperview];
      [self.overlayView removeFromSuperview];
    }];

    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)handleTap {
  NSLog(@"[HCaptchaFlutterPlugin]: handleTap");
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
  return NO;
}

- (UIViewController *)topViewController {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  // TODO(stuartmorgan) Provide a non-deprecated codepath. See
  // https://github.com/flutter/flutter/issues/104117
  return [self topViewControllerFromViewController:[UIApplication sharedApplication]
                                                       .keyWindow.rootViewController];
#pragma clang diagnostic pop
}

/**
 * This method recursively iterate through the view hierarchy
 * to return the top most view controller.
 *
 * It supports the following scenarios:
 *
 * - The view controller is presenting another view.
 * - The view controller is a UINavigationController.
 * - The view controller is a UITabBarController.
 *
 * @return The top most view controller.
 */
- (UIViewController *)topViewControllerFromViewController:(UIViewController *)viewController {
  if ([viewController isKindOfClass:[UINavigationController class]]) {
    UINavigationController *navigationController = (UINavigationController *)viewController;
    return [self
        topViewControllerFromViewController:[navigationController.viewControllers lastObject]];
  }
  if ([viewController isKindOfClass:[UITabBarController class]]) {
    UITabBarController *tabController = (UITabBarController *)viewController;
    return [self topViewControllerFromViewController:tabController.selectedViewController];
  }
  if (viewController.presentedViewController) {
    return [self topViewControllerFromViewController:viewController.presentedViewController];
  }
  return viewController;
}

@end
