import 'package:flutter_android_video_cache_plugin/src/flutter_android_video_cache_plugin.dart';

class VideoCache {
  VideoCache._();

  static final FlutterAndroidVideoCachePlugin videoCache =
      FlutterAndroidVideoCachePlugin();

  static Future<String?> getPlatformVersion() async {
    return await videoCache.getPlatformVersion();
  }

  static Future<void> config(String cacheDirectory, int maxCacheSize) async {
    await videoCache.config(cacheDirectory, maxCacheSize);
  }

  static Future<String> getProxyUrl(String url) async {
    return await videoCache.getProxyUrl(url);
  }
}
