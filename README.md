# flutter_dev_tools

`flutter_dev_tools` is a Flutter package designed to assist developers and QA
professionals in efficiently tracking and resolving issues. It currently
features an HTTP Logger tool, which intercepts HTTP requests made using the Dio
HTTP client and displays them in an intuitive UI. Future updates aim to support
additional HTTP packages.

## Features

- **HTTP Logger**: Intercepts HTTP requests in Dio and displays them in a
  user-friendly UI for easy monitoring and debugging.

  ![screenshot 1](https://github.com/cedvdb/phone_form_field/tree/dev/res/http_logger_1.png)
  ![screenshot 2](https://github.com/cedvdb/phone_form_field/tree/dev/res/http_logger_1.png)

## Getting Started

To use the HTTP Logger with Dio, follow these steps:


1. **Import Necessary Packages**:

   ```dart
   import 'package:dio/dio.dart';
   import 'package:flutter/material.dart';
   import 'package:flutter_riverpod/flutter_riverpod.dart';
   import 'package:flutter_dev_tools/flutter_dev_tools.dart';
    ```

2. **Initialize Dio and Add `HTTPDioLoggerInterceptor`:**:

```dart

Dio dio = Dio(); // Create Dio instance

class MyApp extends ConsumerStatefulWidget {
  // Your Flutter app class
  // ...
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    dio.interceptors.add(
      HTTPDioLoggerInterceptor(
        logger: ref.read(inMemoryLoggerProvider),
      ),
    );
    // Example requests to populate the logger
    dio.get('https://google.com');
    dio.get('https://facebook.com');
  }
// ...
}
```

3. **Access the HTTP Logger UI:**:

```dart
class _MyAppState extends ConsumerState<MyApp> {
  // ...
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
              // ...
              TextButton(
                onPressed: () => FlutterDevTools().openHttpLogger(context),
                child: const Text('HTTP Logger'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

# Contributing

Contributions to flutter_dev_tools are welcome. Whether it's expanding the
current HTTP Logger tool, adding new features, or improving documentation, your
input is valuable.