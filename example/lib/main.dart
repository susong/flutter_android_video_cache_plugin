import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_android_video_cache_plugin/video_cache.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();
    initPlatformState();
    VideoCache.config(
      '/sdcard/mf_video_cache',
      1024 * 1024 * 1024 /*1GB*/,
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await VideoCache.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              TextButton(
                  onPressed: () {
                    String url =
                        "https://media.w3.org/2010/05/sintel/trailer.mp4";
                    _testProxyUrl(url);
                  },
                  child: Text("test1")),
              TextButton(
                  onPressed: () {
                    String url =
                        "http://www.w3school.com.cn/example/html5/mov_bbb.mp4";
                    _testProxyUrl(url);
                  },
                  child: Text("test2")),
              TextButton(
                  onPressed: () {
                    String url =
                        "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
                    _testProxyUrl(url);
                  },
                  child: Text("test3")),
            ],
          ),
        ),
      ),
    );
  }

  void _testProxyUrl(String url) async {
    String proxyUrl = await VideoCache.getProxyUrl(url);
    print("url:$url proxyUrl:$proxyUrl");
  }
}
