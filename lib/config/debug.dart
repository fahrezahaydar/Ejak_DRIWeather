import 'package:flutter/foundation.dart';

void debug(String mes) {
  if (kDebugMode) {
    print(mes);
  }
}
