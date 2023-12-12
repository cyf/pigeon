package com.kjxbyz.plugins.hcaptcha;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.VisibleForTesting;
import androidx.fragment.app.FragmentActivity;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hcaptcha.sdk.HCaptcha;
import com.hcaptcha.sdk.HCaptchaConfig;
import com.hcaptcha.sdk.HCaptchaError;
import com.hcaptcha.sdk.HCaptchaSize;

import java.util.HashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class HCaptchaFlutterPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
  private static final String TAG = "HCaptchaFlutterPlugin";

  private static final String CHANNEL_NAME = "plugins.kjxbyz.com/hcaptcha_flutter_plugin";

  private static final String METHOD_SHOW = "show";

  private MethodChannel channel;
  private HCaptchaDelegateImpl delegate;
  private ActivityPluginBinding activityPluginBinding;

  @SuppressWarnings("deprecation")
  public static void registerWith(io.flutter.plugin.common.PluginRegistry.Registrar registrar) {
    HCaptchaFlutterPlugin instance = new HCaptchaFlutterPlugin();
    instance.initInstance(registrar.messenger(), registrar.context());
    instance.setUpRegistrar(registrar);
  }

  @VisibleForTesting
  public void initInstance(BinaryMessenger messenger, Context context) {
    channel = new MethodChannel(messenger, CHANNEL_NAME);
    delegate = new HCaptchaDelegateImpl(context, channel);
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

  public interface IHCaptchaDelegate {

    /**
     * 展示hcaptcha.
     */
    public void show(HashMap<String, Object> config, MethodChannel.Result result);

  }

  public static class HCaptchaDelegateImpl implements IHCaptchaDelegate, PluginRegistry.ActivityResultListener {
    private static final String TAG = "HCaptchaDelegateImpl";

    private final Context context;

    private final MethodChannel channel;

    @SuppressWarnings("deprecation")
    private PluginRegistry.Registrar registrar;

    private Activity activity;

    private HCaptcha hCaptcha;

    public HCaptchaDelegateImpl(Context context, MethodChannel channel) {
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
     * 展示hcaptcha.
     */
    @Override
    public void show(HashMap<String, Object> config, MethodChannel.Result result) {
      if (this.context == null) {
        Log.e(TAG, "上下文为空");
        return;
      }
      try {
        if (config == null) {
          Log.e(TAG, "hCaptcha配置为空");
          return;
        }

        Log.i(TAG, config.toString());

        String siteKey = (String) config.get("siteKey");
        String language = getDefaultLocale((String) config.get("language"));
        if (siteKey == null || siteKey.isEmpty()) {
          Log.e(TAG, "hCaptcha验证码配置中siteKey字段为空");
          return;
        }

        if (hCaptcha == null) {
          hCaptcha = HCaptcha.getClient((FragmentActivity) getActivity()).verifyWithHCaptcha(getConfig(siteKey, language));
          hCaptcha.addOnSuccessListener(response -> {
            String token = response.getTokenResult();
            Log.i(TAG, "hCaptcha success: " + "(" + token + ")");
            Handler mainHandler = new Handler(Looper.getMainLooper());
            ObjectMapper objectMapper = new ObjectMapper();
            mainHandler.postDelayed(() -> {
              try {
                channel.invokeMethod("success", objectMapper.writeValueAsString(new HashMap(){{
                  put("token", token);
                }}));
              } catch (Exception e) {
                Log.e(TAG, "parse error: " + "(" + e.getMessage() + ")");
              }
            }, 100);
          }).addOnFailureListener(e -> {
            Log.e(TAG, "hCaptcha failed: " + "(" + e.getStatusCode() + ")" + e.getMessage());
            Handler mainHandler = new Handler(Looper.getMainLooper());
            ObjectMapper objectMapper = new ObjectMapper();
            mainHandler.postDelayed(() -> {
              try {
                channel.invokeMethod("error", objectMapper.writeValueAsString(new HashMap(){{
                  put("code", e.getStatusCode());
                  put("msg", e.getMessage());
                }}));
              } catch (Exception e1) {
                Log.e(TAG, "parse error: " + "(" + e1.getMessage() + ")");
              }
            }, 100);
          }).addOnOpenListener(() -> Toast.makeText(this.getActivity(), "hCaptcha shown", Toast.LENGTH_SHORT).show());
        } else {
          hCaptcha.verifyWithHCaptcha();
        }
        result.success(true);
      } catch (Exception e) {
        Log.e(TAG, e.getMessage(), e);
        result.error(METHOD_SHOW, e.getMessage(), null);
      }
    }

    private HCaptchaConfig getConfig(String siteKey, String locale) {
      return HCaptchaConfig.builder()
              .siteKey(siteKey)
              .locale(locale)
              .size(HCaptchaSize.INVISIBLE)
              .loading(true)
              .hideDialog(false)
              .disableHardwareAcceleration(true)
              .tokenExpiration(10)
              .diagnosticLog(true)
              .retryPredicate((config, exception) -> exception.getHCaptchaError() == HCaptchaError.SESSION_TIMEOUT)
              .build();
    }

    private String getDefaultLocale(String val) {
      return val == null || val.isEmpty() ? "en" : val;
    }
  }
}
