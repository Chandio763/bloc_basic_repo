package com.example.smarty_editor_with_block

import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(){
    private val CHANNEL = "com.example.myapp/navigation"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startForegroundService" -> {
                    Log.i("Service", "startForegroundService Invoked")
                    startForegroundService()
                    result.success(null)
                }
                "navigateToSpecificScreen" -> {
                    val intent = Intent(this, MainActivity::class.java)
                    intent.putExtra("navigate_to", "specific_screen")
                    startActivity(intent)
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun startForegroundService() {
        val intent = Intent(this, MyForegroundService::class.java)
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            Log.i("Service", "inside startForegroundService ${android.os.Build.VERSION.SDK_INT}")
            startForegroundService(intent)
        } else {
            Log.i("Service", "inside startForegroundService ${android.os.Build.VERSION.SDK_INT}")
            startService(intent)
        }
    }

//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        flutterEngine?.dartExecutor?.binaryMessenger?.let {
//            MethodChannel(it, CHANNEL).setMethodCallHandler { call, result ->
//                if (call.method == "navigateToSpecificScreen") {
//                    val intent = Intent(this, MainActivity::class.java)
//                    intent.putExtra("navigate_to", "specific_screen")
//                    startActivity(intent)
//                    result.success(null)
//                } else {
//                    result.notImplemented()
//                }
//            }
//        }
//
//        handleIntent(intent)
//
//    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.i("Service", "inside New Intent ")
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent) {
        val navigateTo = intent.getStringExtra("navigate_to")
        Log.i("Service", "inside New Intent ${navigateTo} ")
        if (navigateTo == "specific_screen") {
            Log.i("Service", "inside New Intent Call for screen invoke ${navigateTo} ")
            flutterEngine?.dartExecutor?.binaryMessenger?.let { MethodChannel(it, CHANNEL).invokeMethod("navigateToSpecificScreen", null) }
        }
    }
}
