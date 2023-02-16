import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_android_video_cache_plugin_method_channel.dart';

abstract class FlutterAndroidVideoCachePluginPlatform
    extends PlatformInterface {
  /// Constructs a FlutterAndroidVideoCachePluginPlatform.
  FlutterAndroidVideoCachePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAndroidVideoCachePluginPlatform _instance =
      MethodChannelFlutterAndroidVideoCachePlugin();

  /// The default instance of [FlutterAndroidVideoCachePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAndroidVideoCachePlugin].
  static FlutterAndroidVideoCachePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAndroidVideoCachePluginPlatform] when
  /// they register themselves.
  static set instance(FlutterAndroidVideoCachePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> config(String cacheDirectory, int maxCacheSize) {
    throw UnimplementedError('config() has not been implemented.');
  }

  Future<String> getProxyUrl(String url) {
    throw UnimplementedError('getProxyUrl() has not been implemented.');
  }
}
