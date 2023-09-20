import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalValues with ChangeNotifier{
  //static ValueNotifier<bool> flagTheme = ValueNotifier<bool>(true);
  static late ThemeData current;
  static late bool flag=false;


  ThemeData light=ThemeData.light().copyWith(primaryColor: Colors.green);

  ThemeData dark=ThemeData.dark().copyWith(primaryColor: Colors.black);

  GlobalValues({required bool? isDark}){
    if(isDark!=null){
        current= isDark ? dark : light;
    }else{
      current= light;
    }
  }

  Future<void> swapTheme() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    if(current == dark){
      current=light;
      flag=false;
      prefs.setBool('isDark', false);
    }else{
      current=dark;
      flag=true;
      prefs.setBool('isDark', true);
    }
    notifyListeners();
  }
  ThemeData get getTheme => current;
  bool get getFlag => flag;
  set setFlag(value) => flag=value;

}