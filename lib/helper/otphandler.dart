import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ShowOtpScreen {
  ValueNotifier valueNotifier = ValueNotifier(false);
  updateValue(bool value) {
    valueNotifier.value = value;
  }
}
