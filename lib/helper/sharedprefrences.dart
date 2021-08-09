
import 'package:delivery_app/models/user.dart';
import 'package:hive/hive.dart';



class LocalStorage {
  
  final box = Hive.box('user');

  LocalStorage();
  Future<void> saveBool({String key, bool value}) async {
    await box.put(key, value);
  }

  Future<void> saveUserToStorage(User user) async {
    // String us = jsonEncode(user);
    // await sharedPreferences
    //     .setString('user', us)
    //     .then((value) => print("updated"));

    await box.put('user', user);
  }

  Future<User> getUserFromStorage() async {
    // String json = jsonDecode(sharedPreferences.getString('user'));
    // var user = User.fromJson(json);
    // return user;
    final User user = await box.get('user');
    return user;
  }

  bool contains({String key}) {
    // return sharedPreferences.containsKey(key);
    return box.containsKey(key);
  }
}
