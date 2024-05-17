package com.example.roblox_skin;

import io.flutter.embedding.android.FlutterActivity;

import android.view.LayoutInflater;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;
public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // TODO: Register the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "adFactoryExample",
                new NativeAdFactoryEx(LayoutInflater.from(getContext())));
    }

    @Override
    public void cleanUpFlutterEngine(FlutterEngine flutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine);

        // TODO: Unregister the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryExample");
    }
}