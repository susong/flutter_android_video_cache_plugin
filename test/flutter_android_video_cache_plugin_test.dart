import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_android_video_cache_plugin/src/flutter_android_video_cache_plugin.dart';
import 'package:flutter_android_video_cache_plugin/src/flutter_android_video_cache_plugin_platform_interface.dart';
import 'package:flutter_android_video_cache_plugin/src/flutter_android_video_cache_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAndroidVideoCachePluginPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterAndroidVideoCachePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> config(String cacheDirectory, int maxCacheSize) {
    throw UnimplementedError();
  }

  @override
  Future<String> getProxyUrl(String url) {
    throw UnimplementedError();
  }
}

void main() {
  final FlutterAndroidVideoCachePluginPlatform initialPlatform = FlutterAndroidVideoCachePluginPlatform.instance;

  test('$MethodChannelFlutterAndroidVideoCachePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAndroidVideoCachePlugin>());
  });

  test('getPlatformVersion', () async {
    FlutterAndroidVideoCachePlugin flutterAndroidVideoCachePlugin = FlutterAndroidVideoCachePlugin();
    MockFlutterAndroidVideoCachePluginPlatform fakePlatform = MockFlutterAndroidVideoCachePluginPlatform();
    FlutterAndroidVideoCachePluginPlatform.instance = fakePlatform;
  
    expect(await flutterAndroidVideoCachePlugin.getPlatformVersion(), '42');
  });
}
