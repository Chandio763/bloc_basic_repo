import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  void initState() {
    scheduleTask();
    // initializeService();
    super.initState();
  }

  @pragma('vm:entry-point')
  Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    // scheduleTask();
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }
    service.on('stopService').listen((event) {
      service.stopSelf();
    });
    Timer.periodic(Duration(minutes: 1),(timer){
      //Launnch App 
      print('1 Minutes passed');
    });
  }

  Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'my_foreground',
        initialNotificationContent: 'Reminder',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
    if(await service.isRunning()){
      service.invoke('stopService');
    }
    service.startService();
  }

  static void scheduleTask() async {
    const int helloAlarmID = 0;
    await AndroidAlarmManager.periodic(
      Duration(minutes: 100), // Schedule task every 1 minute for testing purposes
      helloAlarmID,
      _callback,
      // alarmClock: true,
      params: {
        'screen': 'confirmScreen',
      },
      exact: true,
      wakeup: true,
    );
  }

  static void _callback(int i, Map<String, dynamic>? paramsExtra) {
    print('Alarm fired! Opening app...');
    // if (paramsExtra != null){
    //   // The received params is a string, so we need to convert it into a json map
    //   final params = jsonDecode(paramsExtra);
    //   // use params
    //   var screenName = params['screen'];
    //   if (screenName !=null) {
    //     Navigator.of(context).push(MaterialPageRoute(builder: (context){
    //       return const ConnfirmationScreen();
    //     }));
    //   }
      // params['param2']
    // }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Reminder Screen')),
    );
  }
}
