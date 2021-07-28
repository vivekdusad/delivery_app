import 'dart:convert';
import 'package:delivery_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences sharedPreferences;
  LocalStorage({this.sharedPreferences});
  Future<void> saveBool({String key, bool value}) async {
    await sharedPreferences.setBool(key, value);
  }

  Future<void> saveUserToStorage(User user) async {
    String us = jsonEncode(user);
    await sharedPreferences
        .setString('user', us)
        .then((value) => print("updated"));
  }

  Future<User> getUserFromStorage() async {
    String json = jsonDecode(sharedPreferences.getString('user'));
    var user = User.fromJson(json);
    return user;
  }

  bool contains({String key}) {
    return sharedPreferences.containsKey(key);
  }
}
