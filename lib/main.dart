import 'dart:convert';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

import 'package:receive_intent/receive_intent.dart';

import 'ui/confirmation_screen.dart';
import 'ui/reminder_screen.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // static const platform = MethodChannel('com.example.myapp/navigation');

  @override
  void initState() {
    super.initState();
    checkCallingIntent();
  }

  checkCallingIntent() async{
    final receivedIntent = await ReceiveIntent.getInitialIntent();
    if (receivedIntent?.action == "android.intent.action.MAIN"){
    final paramsExtra = receivedIntent?.extra?["params"];
    if (paramsExtra != null){
      // The received params is a string, so we need to convert it into a json map
      final params = jsonDecode(paramsExtra);
      // use params
      var screenName = params['screen'];
      if (screenName !=null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return const ConnfirmationScreen();
        }));
      }
      // params['param2']
    }
    // final id = receivedIntent?.extra?["id"];
    // navigate user to alarm with given id
}
  }
  

  @override
  void dispose() {
    // ForegroundService().stopForegroundService();
    super.dispose();
  }

  // Future<void> _handleMethod(MethodCall call) async {
  //   if (call.method == 'navigateToSpecificScreen') {
  //     Navigator.of(context).pushNamed('specific_screen');
  //   }
  // }

  // Future<void> _startForegroundService() async {
  //   try {
  //     await platform.invokeMethod('startForegroundService');
  //   } on PlatformException catch (e) {
  //     print("Failed to start foreground service: '${e.message}'.");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ReminderScreen()
      // home: BlocProvider(
      //   create: (context) => PostBloc(apiService: ApiService()),
      //   child: const PostsView(),
      // ),
      // routes: {
      //   'specific_screen': (context) => CounterPage(),
      // },
    );
  }
}