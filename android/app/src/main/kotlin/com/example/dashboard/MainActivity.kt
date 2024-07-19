package com.example.dashboard

import android.content.Intent
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.LinearLayout
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)


        // Cache the FlutterEngine to be used by other activities
        FlutterEngineCache
            .getInstance()
            .put("my_engine_id", flutterEngine)


        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "renderSection") {
                val intent = Intent(this, SecondActivity::class.java)
                val params = call.arguments as String
                intent.putExtra("params", params)
                startActivity(intent)
            } else {
                result.notImplemented()
            }
        }
    }


}
