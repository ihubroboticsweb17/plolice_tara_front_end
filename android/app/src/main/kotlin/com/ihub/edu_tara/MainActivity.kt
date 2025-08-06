package com.ihub.edu_tara

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.share_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        handleShareIntent(intent, channel)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)

        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            val channel = MethodChannel(messenger, CHANNEL)
            handleShareIntent(intent, channel)
        }
    }

    private fun handleShareIntent(intent: Intent?, channel: MethodChannel) {
        if (intent?.action == Intent.ACTION_VIEW && intent.data != null) {
            val uri = intent.data
            val userId = uri?.getQueryParameter("user_id")
            val id = userId?.toIntOrNull()
            id?.let {
                channel.invokeMethod("onShareReceived", it)
            }
        }
    }
}
