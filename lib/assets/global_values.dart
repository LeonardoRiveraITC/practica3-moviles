import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalValues with ChangeNotifier {
  static ValueNotifier<bool> flagTask = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagProfessor = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagCareer = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagHomework = ValueNotifier<bool>(true);
  static late ThemeData current;
  static late bool flag = false;
  static late String? user = '';

  ThemeData light = ThemeData.light().copyWith(primaryColor: Colors.green);

  ThemeData dark = ThemeData.dark().copyWith(primaryColor: Colors.black);

  GlobalValues({required bool? isDark}) {
    retrieveUser();
    if (isDark != null) {
      flag = isDark ? true : false;
      current = isDark ? dark : light;
    } else {
      current = light;
      flag = false;
    }
  }

  Future<void> swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (current == dark) {
      current = light;
      flag = false;
      prefs.setBool('isDark', false);
    } else {
      current = dark;
      flag = true;
      prefs.setBool('isDark', true);
    }
    notifyListeners();
  }

  static Future<void> saveUser(String userA, bool? checked) async {
    if (checked!) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', userA);
    }
    user = userA;
  }

  Future<String?> retrieveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = '';
    if (prefs.getString('user') != null) {
      user = prefs.getString('user');
    }
    return user;
  }

  static Future<void> deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', '');
  }

  ThemeData get getTheme => current;
  bool get getFlag => flag;
  set setFlag(value) => flag = value;
  Future<String?> get getUser => retrieveUser();
  set setUser(value) => user = value;
}
