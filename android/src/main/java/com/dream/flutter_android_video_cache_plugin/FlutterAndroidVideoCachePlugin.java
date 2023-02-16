package com.dream.flutter_android_video_cache_plugin;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FlutterAndroidVideoCachePlugin
 */
public class FlutterAndroidVideoCachePlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_android_video_cache_plugin");
        channel.setMethodCallHandler(this);
        FlutterAndroidVideoCacheWrapper.getInstance().setContext(flutterPluginBinding.getApplicationContext());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        FlutterAndroidVideoCacheWrapper.getInstance().shutdown();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("config")) {
            String cacheDirectory = call.argument("cacheDirectory");
            String maxCacheSizeStr = call.argument("maxCacheSize");
            long maxCacheSize = 0;
            if (maxCacheSizeStr != null && maxCacheSizeStr.length() > 0) {
                try {
                    maxCacheSize = Long.parseLong(maxCacheSizeStr);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
            FlutterAndroidVideoCacheWrapper.getInstance().config(cacheDirectory, maxCacheSize);
            result.success(null);
        } else if (call.method.equals("getProxyUrl")) {
            String url = call.argument("url");
            String proxyUrl = FlutterAndroidVideoCacheWrapper.getInstance().getProxyUrl(url);
            result.success(proxyUrl);
        } else {
            result.notImplemented();
        }
    }
}
