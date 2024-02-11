

import 'package:flutter/foundation.dart';

void printWarning(String? text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}

void printLog(String? text) {
  if (kDebugMode) {
    print('\x1B[31m - Ramzan Debug print\x1B[0m '
    '\x1B[36m => \x1B[0m'
        '\x1B[32m$text\x1B[0m');
  }
}

void printError(String text) {
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m');
  }
}