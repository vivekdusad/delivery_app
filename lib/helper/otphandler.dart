import 'package:flutter/cupertino.dart';

class ShowOtpScreen extends ChangeNotifier {
  bool isOtpSent = false;
  updateValue(bool value) {
    isOtpSent = value;
    notifyListeners();
  }
}
