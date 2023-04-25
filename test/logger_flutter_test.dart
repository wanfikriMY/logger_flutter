import 'package:flutter_test/flutter_test.dart';

import 'package:logger_flutter/logger_flutter.dart';

void main() {
  const String message = "THIS IS JUST A TEST";
  test("Logger Test", () {
    Logger().setLogLevel(LogLevel.debugFinest);

    Object object = Object();

    logInfo("logInfo", message);
    logDebug("logDebug", message);
    logDebugFine("logDebugFine", message);
    logDebugFiner("logDebugFiner", message);
    logDebugFinest("LogDebugFinest", message);
    logSuccess("logSuccess", message);
    logWarning("logWarning", message);
    logError('logError', message);
    logErrorObject("logErrorObject", object, message);
    logFatal("logFatal", object, message);
  });

  test("Full Test", () {
    // Log header:
    const String _h = 'main';

    int fibonacci(int n) {
      if (n <= 2) {
        if (n < 0) logError(_h, 'Unexpected negative n: $n');
        return 1;
      } else {
        logDebugFinest(_h, 'recursion: n = $n');
        return fibonacci(n - 2) + fibonacci(n - 1);
      }
    }

    Future<Object> fetchUserData() {
      // Imagine that this function is fetching user info but encounters a bug.
      return Future.delayed(
        const Duration(seconds: 3),
        () => throw Exception('Logout failed: user ID is invalid'),
      );
    }

    // Set log level to show.
    // Can be set only once. No need to configure it anywhere else in your app.
    Logger().setLogLevel(LogLevel.debugFinest);

    // Example: log time for app initialization (part 1/2).
    final timer0 = logTimerStart(_h, 'Starting...', level: LogLevel.info);

    // Example: Fibonacci function.
    logDebug(_h, 'Fibonacci(4) is: ${fibonacci(4)}');

    Logger().setLogLevel(LogLevel.debug); // skip log levels lower than debug.
    logDebug(_h, 'Fibonacci(5) is: ${fibonacci(5)}');

    logDebug(_h, 'Fibonacci(-42) is: ${fibonacci(-42)}');

    Logger().setLogLevel(LogLevel.debugFinest); // show all logs again.

    // Example: await an async operation to complete and log the time spent.
    final timer1 = logTimerStart(_h, 'Loading settings...');

    logTimerStop(_h, timer1, 'Settings loaded');

    // Example: call an expensive async operation and do not await it to finish.
    final timer2 = logTimerStart(_h, 'Starting an expensive async operation...');
    Future.delayed(
      const Duration(seconds: 2),
      () => logTimerStop(_h, timer2, 'Completed the expensive async operation'),
    );
    logDebugFinest(_h, 'This line runs before the expensive async completes');

    // Example: call an expensive async operation that may fail; do not await it.
    logDebugFinest(_h, 'Starting a second expensive async operation...');
    fetchUserData().then((result) {
      logDebugFine(_h, 'Got the result: $result');
    }).catchError((error) {
      logErrorObject(_h, error, 'Caught an error in the async operation!');
    });

    // Example: log time for app initialization (part 2/2).
    logTimerStop(_h, timer0, 'Initialization completed', level: LogLevel.success);

    // Run the app and pass in the SettingsController. The app listens to the
    // SettingsController for changes, then passes it further down to the
    // SettingsView.
  });
}

class Object {
  String name = "Tester";
  int age = 27;
}
