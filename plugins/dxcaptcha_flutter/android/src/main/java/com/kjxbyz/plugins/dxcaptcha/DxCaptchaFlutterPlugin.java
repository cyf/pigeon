package com.kjxbyz.plugins.dxcaptcha;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.webkit.WebView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.VisibleForTesting;

import com.dx.mobile.captcha.DXCaptchaListener;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class DxCaptchaFlutterPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
    private static final String TAG = "DxCaptchaFlutterPlugin";

    private static final String CHANNEL_NAME = "plugins.kjxbyz.com/dxcaptcha_flutter_plugin";

    private static final String METHOD_SHOW = "show";

    private MethodChannel channel;
    private DxCaptchaDelegateImpl delegate;
    private ActivityPluginBinding activityPluginBinding;

    @SuppressWarnings("deprecation")
    public static void registerWith(io.flutter.plugin.common.PluginRegistry.Registrar registrar) {
        DxCaptchaFlutterPlugin instance = new DxCaptchaFlutterPlugin();
        instance.initInstance(registrar.messenger(), registrar.context());
        instance.setUpRegistrar(registrar);
    }

    @VisibleForTesting
    public void initInstance(BinaryMessenger messenger, Context context) {
        channel = new MethodChannel(messenger, CHANNEL_NAME);
        delegate = new DxCaptchaDelegateImpl(context, channel);
        channel.setMethodCallHandler(this);
    }

    @VisibleForTesting
    @SuppressWarnings("deprecation")
    public void setUpRegistrar(PluginRegistry.Registrar registrar) {
        delegate.setUpRegistrar(registrar);
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPlugin.FlutterPluginBinding binding) {
        initInstance(binding.getBinaryMessenger(), binding.getApplicationContext());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        dispose();
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
        attachToActivity(activityPluginBinding);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        disposeActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
        attachToActivity(activityPluginBinding);
    }

    @Override
    public void onDetachedFromActivity() {
        disposeActivity();
    }

    private void attachToActivity(ActivityPluginBinding activityPluginBinding) {
        this.activityPluginBinding = activityPluginBinding;
        activityPluginBinding.addActivityResultListener(delegate);
        delegate.setActivity(activityPluginBinding.getActivity());
    }

    private void disposeActivity() {
        activityPluginBinding.removeActivityResultListener(delegate);
        delegate.setActivity(null);
        activityPluginBinding = null;
    }

    private void dispose() {
        delegate = null;
        channel.setMethodCallHandler(null);
        channel = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case METHOD_SHOW:
                HashMap<String, Object> config = (HashMap<String, Object>) call.arguments;
                Log.i(TAG, config.toString());
                delegate.show(config, result);
                break;
//            case METHOD_SET_DEBUG_MODE:
//                boolean debugMode = call.argument("debugMode");
//                delegate.setDebugMode(debugMode, result);
//                break;
//            case METHOD_SET_AUTH:
//                boolean auth = call.argument("auth");
//                delegate.setAuth(auth, result);
//                break;
//            case METHOD_INIT:
//                delegate.init(result);
//                break;
//            case METHOD_SET_ALIAS:
//                int sequence = call.argument("sequence");
//                String alias = call.argument("alias");
//                delegate.setAlias(sequence, alias, result);
//                break;
//            case METHOD_DELETE_ALIAS:
//                int deleteSequence = call.argument("sequence");
//                delegate.deleteAlias(deleteSequence, result);
//                break;
            default:
                result.notImplemented();
        }
    }

    public interface IDxCaptchaDelegate {

        /**
         * 展示顶象captcha.
         */
        public void show(HashMap<String, Object> config, MethodChannel.Result result);

    }

    public static class DxCaptchaDelegateImpl implements IDxCaptchaDelegate, PluginRegistry.ActivityResultListener {
        private static final String TAG = "DxCaptchaDelegateImpl";

        private final Context context;
        private final MethodChannel channel;

        @SuppressWarnings("deprecation")
        private PluginRegistry.Registrar registrar;

        private Activity activity;

        public DxCaptchaDelegateImpl(Context context, MethodChannel channel) {
            this.context = context;
            this.channel = channel;
        }

        @SuppressWarnings("deprecation")
        public void setUpRegistrar(PluginRegistry.Registrar registrar) {
            this.registrar = registrar;
            registrar.addActivityResultListener(this);
        }

        public void setActivity(Activity activity) {
            this.activity = activity;
        }

        // Only access activity with this method.
        public Activity getActivity() {
            return registrar != null ? registrar.activity() : activity;
        }

        @Override
        public boolean onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
            return false;
        }

        /**
         * 展示顶象captcha.
         */
        @Override
        public void show(HashMap<String, Object> config, MethodChannel.Result result) {
            if (this.context == null) {
                Log.e(TAG, "上下文为空");
                return;
            }
            try {
                Log.i(TAG, config.toString());
                Handler mainHandler = new Handler(Looper.getMainLooper());
                DxCaptchaDialog dxCaptchaDialog = new DxCaptchaDialog(getActivity(), config);
                dxCaptchaDialog.setListener(new DXCaptchaListener() {
                    boolean passByServer;
                    @Override
                    public void handleEvent(WebView webView, String dxCaptchaEvent, Map map) {
                        Log.e(TAG, "dxCaptchaEvent:" + dxCaptchaEvent);
                        ObjectMapper objectMapper = new ObjectMapper();
                        switch (dxCaptchaEvent) {
                            case "passByServer":
                                passByServer = true;
                                break;
                            case "success":
//                                mSuccess = true;
                                mainHandler.postDelayed(() -> {
                                    dxCaptchaDialog.dismiss();
                                    try {
                                        channel.invokeMethod("success", objectMapper.writeValueAsString(map));
                                    } catch (Exception e) {
                                        Log.e(TAG, "parse error: " + "(" + e.getMessage() + ")");
                                    }
                                }, 100);
                                break;
                            case "fail":
                                mainHandler.postDelayed(() -> {
                                    try {
                                        channel.invokeMethod("error", objectMapper.writeValueAsString(map));
                                    } catch (Exception e) {
                                        Log.e(TAG, "parse error: " + "(" + e.getMessage() + ")");
                                    }
                                }, 100);
                                break;
                            case "onCaptchaJsLoaded":
                                break;
                            case "onCaptchaJsLoadFail": {
                                // 这种情况下请检查captchaJs配置，或者您cdn网络，或者与之相关的数字证书
                                Toast.makeText(context, "检测到验证码加载错误，请点击重试", Toast.LENGTH_LONG).show();
                                break;
                            }
                        }
                    }
                });

                dxCaptchaDialog.init(-1);

                if (!dxCaptchaDialog.isShowing()) {
                    dxCaptchaDialog.show();
                }
                result.success(true);
            } catch (Exception e) {
                Log.e(TAG, e.getMessage(), e);
                result.error(METHOD_SHOW, e.getMessage(), null);
            }

        }

    }
}
