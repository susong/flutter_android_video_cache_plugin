import 'flutter_android_video_cache_plugin_platform_interface.dart';

class FlutterAndroidVideoCachePlugin {
  Future<String?> getPlatformVersion() {
    return FlutterAndroidVideoCachePluginPlatform.instance.getPlatformVersion();
  }

  Future<void> config(String cacheDirectory, int maxCacheSize) async {
    await FlutterAndroidVideoCachePluginPlatform.instance
        .config(cacheDirectory, maxCacheSize);
  }

  Future<String> getProxyUrl(String url) {
    return FlutterAndroidVideoCachePluginPlatform.instance.getProxyUrl(url);
  }
}
