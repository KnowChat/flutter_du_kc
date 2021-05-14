package com.md.flutter_du_kc;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;
import cn.shuzilm.core.Listener;
import cn.shuzilm.core.Main;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FlutterDuKcPlugin */
public class FlutterDuKcPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;
  private String cdidStr;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    context = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_du_kc");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull final Result result) {
    if (call.method.equals("initWithCustomerID")) {
      try {
        String customerId = call.argument("customerID");
        Main.init(context, customerId);
        result.success(null);
      }catch (Exception e) {
        e.printStackTrace();
      }
    } else if (call.method.equals("getDeviceID")) {
      if (cdidStr != null && cdidStr.length() > 0) {
        result.success(cdidStr);
      }else  {
        String msg1 = call.argument("msg1");
        String msg2 = call.argument("msg2");
        try {
          Main.getQueryID(context, msg1, msg2, 1, new Listener() {
            @Override
            public void handler(String s) {
              cdidStr = s;
              Handler handler = new Handler(Looper.getMainLooper());
              handler.post(new Runnable() {
                  @Override
                  public void run() {
                    result.success(cdidStr);
                  }
                });
            }
          });
        }catch (Exception e) {
          e.printStackTrace();
        }
      }
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
