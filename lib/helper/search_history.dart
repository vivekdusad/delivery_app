import 'package:flutter/material.dart';

class SearchHistory extends ChangeNotifier {
  List<String> history = ["hello"];
  void addHistory(String s) {
    history.add(s);
    notifyListeners();
  }

  void removeHistory(String s) {
    history.remove(s);
    notifyListeners();
  }
}
