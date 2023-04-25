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
}

class Object {
  String name = "Tester";
  int age = 27;
}
