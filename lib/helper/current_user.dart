import 'package:delivery_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class CurrentUserNotifer extends ChangeNotifier {
  User currentUser;
  void updateUser(User user) {
    currentUser = user;
    notifyListeners();
  }
}
