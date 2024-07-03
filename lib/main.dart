import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarty_editor_with_block/ui/counter_view.dart';
import 'package:smarty_editor_with_block/ui/posts/posts_view.dart';

import 'bloc/posts_bloc/post_bloc.dart';
import 'bloc/posts_bloc/post_event.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('com.example.myapp/navigation');

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(_handleMethod);
    _startForegroundService();
  }

  Future<void> _handleMethod(MethodCall call) async {
    if (call.method == 'navigateToSpecificScreen') {
      Navigator.of(context).pushNamed('specific_screen');
    }
  }

  Future<void> _startForegroundService() async {
    try {
      await platform.invokeMethod('startForegroundService');
    } on PlatformException catch (e) {
      print("Failed to start foreground service: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => PostBloc(apiService: ApiService()),
        child: const PostsView(),
      ),
      routes: {
        'specific_screen': (context) => CounterPage(),
      },
    );
  }
}