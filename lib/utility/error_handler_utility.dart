import 'package:flutter/foundation.dart';

class ErrorHandlerUtility {
  ErrorHandlerUtility._();

  static handle(Object? error, StackTrace stackTrace, [Function()? callback]) {
    debugPrint(error.toString());
    debugPrint(stackTrace.toString());
    callback?.call();
  }
}
