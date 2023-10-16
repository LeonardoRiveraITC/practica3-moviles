import 'package:flutter/widgets.dart';
import 'package:pmsn20232/screens/add_career.dart';
import 'package:pmsn20232/screens/add_professor.dart';
import 'package:pmsn20232/screens/add_task.dart';
import 'package:pmsn20232/screens/career_screen.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/popular_screen.dart';
import 'package:pmsn20232/screens/professor_screen.dart';
import 'package:pmsn20232/screens/task_screen.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/dash': (BuildContext context) => DashboardScreen(),
    '/task': (BuildContext context) => TaskScreen(),
    '/add': (BuildContext context) => AddTask(),
    '/add_professor': (BuildContext context) => AddProfessor(),
    '/professor': (BuildContext context) => ProfessorScreen(),
    '/career': (BuildContext context) => CareerScreen(),
    '/add_career': (BuildContext context) => AddCareer(),
    '/popular': (BuildContext context) => PopularScreen()
    //'/career': (BuildContext context) => CareerScreen(),
    //'/homework': (BuildContext context) => HomeworkScreen(),
  };
}
