import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/assets/styles_app.dart';
import 'package:pmsn20232/routes.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';

Future<void> main() async {
SharedPreferences prefs= await SharedPreferences.getInstance();
return runApp(ChangeNotifierProvider(
  child:MyApp(),
  create:(_) =>GlobalValues(isDark: prefs.getBool('isDark')??false))
);
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  Widget home=LoginScreen();

  Future<void> homeSet() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
     home=prefs.getString('user')!=null ? DashboardScreen():LoginScreen();
  } 
  @override
  Widget build(BuildContext context) {
        return Consumer<GlobalValues>(
          builder: (context,provider,child) {
            return MaterialApp(
              home: home,
              routes: getRoutes(),
              theme: provider.getTheme
              /*routes: {
                '/dash' : (BuildContext context) => LoginScreen()
              },*/
            );
          }
        );
      }
  }