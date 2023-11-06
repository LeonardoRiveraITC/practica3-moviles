import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/assets/styles_app.dart';
import 'package:pmsn20232/routes.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //bool logon = await prefs.getString('user')!.isNotEmpty;
  Widget home = LoginScreen();
  return runApp(ChangeNotifierProvider(
      child: MyApp(home: home),
      create: (_) => GlobalValues(isDark: prefs.getBool('isDark') ?? false)));
}

class MyApp extends StatelessWidget {
  final Widget home;
  MyApp({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalValues>(builder: (context, provider, child) {
      return MaterialApp(
          home: home, routes: getRoutes(), theme: provider.getTheme
          /*routes: {
                '/dash' : (BuildContext context) => LoginScreen()
              },*/
          );
    });
  }
}
