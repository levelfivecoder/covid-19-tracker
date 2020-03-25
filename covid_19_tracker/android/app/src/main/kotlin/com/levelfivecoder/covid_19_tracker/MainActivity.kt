package com.levelfivecoder.covid_19_tracker

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.microsoft.appcenter.AppCenter;
import com.microsoft.appcenter.analytics.Analytics;
import com.microsoft.appcenter.crashes.Crashes;

class MainActivity: FlutterActivity() {
    
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
