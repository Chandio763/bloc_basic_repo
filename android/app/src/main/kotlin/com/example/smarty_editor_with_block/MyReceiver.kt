package com.example.smarty_editor_with_block

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.core.content.ContextCompat

class MyReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {

        val navigateTo = intent.getStringExtra("navigate_to")
        Log.i("Service", "inside Broad Receiver ${navigateTo} ")
        if (navigateTo == "specific_screen") {
//            flutterEngine?.dartExecutor?.binaryMessenger?.let { MethodChannel(it, CHANNEL).invokeMethod("navigateToSpecificScreen", null) }

            val startActivityIntent = Intent(context, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                putExtra("navigate_to", "specific_screen")
            }
            Log.i("Service", "inside Broad Recive ${navigateTo} ")
            ContextCompat.startActivity(context, startActivityIntent, null)
        }
    }
}
