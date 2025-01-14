package com.example.shop;
import android.app.Application;

import com.yandex.mapkit.MapKitFactory;

public class MainApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
       // MapKitFactory.setLocale("YOUR_LOCALE"); // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("a1ebe68a-a5db-4f28-878f-c62d393cd0e8"); // Your generated API key
    }
}