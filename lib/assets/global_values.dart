import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalValues with ChangeNotifier{
  //static ValueNotifier<bool> flagTheme = ValueNotifier<bool>(true);
  static late ThemeData current;
  static late bool flag=false;
  static late String? user=''; 

  ThemeData light=ThemeData.light().copyWith(primaryColor: Colors.green);

  ThemeData dark=ThemeData.dark().copyWith(primaryColor: Colors.black);

  GlobalValues({required bool? isDark}){
    retrieveUser();
    if(isDark!=null){
        flag= isDark ? true : false;
        current= isDark ? dark : light;
    }else{
      current= light;
      flag=false;
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

  Future<void> saveUser(String userA,bool? checked) async{
    if(checked!){
      SharedPreferences prefs= await SharedPreferences.getInstance();
      prefs.setString('user', userA);
    }
    user=userA;
    notifyListeners();
  }
  Future<void> retrieveUser() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    if(prefs.getString('user')!=null){
      user=prefs.getString('user');
    }
    notifyListeners();
  }
  
  ThemeData get getTheme => current;
  bool get getFlag => flag;
  set setFlag(value) => flag=value;
  String get getUser => user as String;
  set setUser(value) => user=value;  
  
}