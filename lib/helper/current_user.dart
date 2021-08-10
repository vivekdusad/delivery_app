import 'package:delivery_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class CurrentUserNotifer extends ChangeNotifier {
  Users currentUser;
  void updateUser(Users user) {
    currentUser = user;
    notifyListeners();
  }
}
