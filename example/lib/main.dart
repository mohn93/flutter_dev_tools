import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_tools/shared/alerts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dev_tools/flutter_dev_tools.dart';
import 'package:flutter_dev_tools/tools/http_logger/ui/http_logger_screen.dart';
import 'package:flutter_dev_tools/tools/http_logger/application/application.dart';

Dio dio = Dio();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    dio.interceptors.add(
      HTTPDioLoggerInterceptor(
        logger: ref.read(httpLoggerProvider),
      ),
    );
    // create requests to google and facebook to fill out the logger
    dio.get('https://google.com');
    dio.get('https://facebook.com');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  AppDevAlerts.showInfoDialog(context,
                      message: (await FlutterDevTools().diagnoseDynamicLinks())
                          .toString());
                },
                child: const Text('Diagnose Dynamic Links'),
              ),
              const SizedBox(height: 16),
              Builder(builder: (context) {
                return TextButton(
                  onPressed: () => FlutterDevTools().openHttpLogger(context),
                  child: const Text('HTTP Logger'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
