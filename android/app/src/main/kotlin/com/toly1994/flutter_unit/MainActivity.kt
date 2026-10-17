package com.toly1994.flutter_unit

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        ArticleImageChannel.register(this, flutterEngine.dartExecutor.binaryMessenger)
    }
}
