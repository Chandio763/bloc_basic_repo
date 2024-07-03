package com.example.smarty_editor_with_block

import android.app.AlarmManager
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import java.util.Calendar

class MyForegroundService : Service() {
    private val CHANNEL_ID = "ForegroundServiceChannel"

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        val notificationIntent = Intent(this, MainActivity::class.java).apply {
            putExtra("navigate_to", "specific_screen")
        }

        val pendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, PendingIntent.FLAG_UPDATE_CURRENT)

        val notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Foreground Service")
            .setContentText("Running...")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentIntent(pendingIntent)
            .build()

        startForeground(1, notification)

        // Do some work in the foreground service
        scheduleActivityStart()

        return START_NOT_STICKY
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val serviceChannel = NotificationChannel(
                CHANNEL_ID,
                "Foreground Service Channel",
                NotificationManager.IMPORTANCE_DEFAULT
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(serviceChannel)
        }
    }

    private fun scheduleActivityStart() {
        Log.i("Service", "inside scheduleActivityStart")
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager

        // Set the time you want the activity to start
        val calendar = Calendar.getInstance().apply {
            set(Calendar.HOUR, 1)  // 3 PM
            set(Calendar.MINUTE,20)       // 3:30 PM
            set(Calendar.SECOND, 0)
        }

        val intent = Intent(this, MyReceiver::class.java).apply {
            putExtra("navigate_to", "specific_screen")
        }
        val pendingIntent = PendingIntent.getBroadcast(this, 1, intent, PendingIntent.FLAG_UPDATE_CURRENT)
        Log.i("Service", "inside Alarm Set ${calendar.time} ")
        // Schedule the alarm
        alarmManager.setExact(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, pendingIntent)
    }

    override fun onDestroy() {
        super.onDestroy()
    }
}
