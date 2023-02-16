import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_android_video_cache_plugin/src/flutter_android_video_cache_plugin_method_channel.dart';

void main() {
  MethodChannelFlutterAndroidVideoCachePlugin platform = MethodChannelFlutterAndroidVideoCachePlugin();
  const MethodChannel channel = MethodChannel('flutter_android_video_cache_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
