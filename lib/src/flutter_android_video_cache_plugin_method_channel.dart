import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_android_video_cache_plugin_platform_interface.dart';

/// An implementation of [FlutterAndroidVideoCachePluginPlatform] that uses method channels.
class MethodChannelFlutterAndroidVideoCachePlugin
    extends FlutterAndroidVideoCachePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel('flutter_android_video_cache_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> config(String cacheDirectory, int maxCacheSize) async {
    await methodChannel.invokeMethod(
      'config',
      {
        'cacheDirectory': cacheDirectory,
        'maxCacheSize': '$maxCacheSize',
      },
    );
  }

  @override
  Future<String> getProxyUrl(String url) async {
    final proxyUrl = await methodChannel.invokeMethod<String>(
      'getProxyUrl',
      {
        'url': url,
      },
    );
    return proxyUrl ?? '';
  }
}
