# flutter_dev_tools

A Flutter HTTP logger for Dio. It records requests, responses, and errors in memory and displays them in a screen inside your app.

| Headers view | HTTP logger |
|:---:|:---:|
| ![Headers view](https://raw.githubusercontent.com/mohn93/flutter_dev_tools/main/res/http_logger_1.png) | ![HTTP logger](https://raw.githubusercontent.com/mohn93/flutter_dev_tools/main/res/http_logger_2.png) |

## Usage

Wrap your app in `ProviderScope`, add the interceptor to your Dio instance, then open the logger screen from a widget:

```dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dev_tools/flutter_dev_tools.dart';
import 'package:flutter_dev_tools/tools/http_logger/application/application.dart';
import 'package:flutter_dev_tools/tools/http_logger/ui/http_logger_screen.dart';

final dio = Dio();

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    dio.interceptors.add(HTTPDioLoggerInterceptor(
      logger: ref.read(httpLoggerProvider),
    ));
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: TextButton(
                onPressed: () => FlutterDevTools().openHttpLogger(context),
                child: const Text('HTTP Logger'),
              ),
            ),
          ),
        ),
      );
}
```

The complete runnable example is in [`example`](example/).
