package com.dream.flutter_android_video_cache_plugin;

import android.content.Context;
import android.os.Environment;


import com.dream.video.cache.HttpProxyCacheServer;

import java.io.File;
import java.lang.ref.WeakReference;

public class FlutterAndroidVideoCacheWrapper {

    private FlutterAndroidVideoCacheWrapper() {

    }

    private static class SingletonHolder {
        private static final FlutterAndroidVideoCacheWrapper INSTANCE = new FlutterAndroidVideoCacheWrapper();
    }

    public static FlutterAndroidVideoCacheWrapper getInstance() {
        return SingletonHolder.INSTANCE;
    }

    private WeakReference<Context> context;
    private HttpProxyCacheServer httpProxyCacheServer;

    public void setContext(Context context) {
        this.context = new WeakReference<>(context);
    }

    public void shutdown() {
        if (httpProxyCacheServer != null) {
            httpProxyCacheServer.shutdown();
            httpProxyCacheServer = null;
        }
    }

    public void config(String cacheDirectory, long maxCacheSize) {
        if (context == null || context.get() == null) {
            return;
        }
        if (cacheDirectory == null || cacheDirectory.length() == 0) {
            cacheDirectory = Environment.getExternalStorageDirectory().getPath() + "/video_cache";
        }
        if (maxCacheSize <= 0) {
            maxCacheSize = 500 * 1024 * 1024;/*500MB*/
        }
        File file = new File(cacheDirectory);
        if (!file.exists()) {
            file.mkdirs();
        }
        shutdown();
        httpProxyCacheServer = new HttpProxyCacheServer.Builder(context.get())
                .cacheDirectory(file)
                .maxCacheSize(maxCacheSize)
                .build();
    }

    public String getProxyUrl(String url) {
        if (httpProxyCacheServer == null) {
            return url;
        }
        if (url == null || url.length() == 0) {
            return url;
        }
        return httpProxyCacheServer.getProxyUrl(url);
    }
}
