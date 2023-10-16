import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:provider/provider.dart';
import 'package:pmsn20232/assets/global_values.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenidos :)'),
      ),
      drawer: createDrawer(context),
    );
  }

  Widget createDrawer(context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
              accountName: Text(
                  Provider.of<GlobalValues>(context, listen: false).getUser),
              accountEmail: Text('mail.com')),
          ListTile(
            //leading: Image.network('https://cdn3.iconfinder.com/data/icons/street-food-and-food-trucker-1/64/fruit-organic-plant-orange-vitamin-64.png'),
            leading: Image.asset('assets/naranja.png'),
            trailing: Icon(Icons.chevron_right),
            title: Text('FruitApp'),
            subtitle: Text('Carrusel'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Task Manager'),
            onTap: () => Navigator.pushNamed(context, '/task'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
            title: Text('Movies'),
            onTap: () => Navigator.pushNamed(context, '/popular'),
          ),
          ListTile(
            leading: Icon(Icons.school),
            trailing: Icon(Icons.chevron_right),
            title: Text('Carreras'),
            onTap: () => Navigator.pushNamed(context, '/career'),
          ),
          ListTile(
            leading: Icon(Icons.verified_user_sharp),
            trailing: Icon(Icons.chevron_right),
            title: Text('Profesores'),
            onTap: () => Navigator.pushNamed(context, '/professor'),
          ),
          ListTile(
            leading: Icon(Icons.task_alt),
            trailing: Icon(Icons.chevron_right),
            title: Text('Tareas'),
            onTap: () => Navigator.pushNamed(context, '/homework'),
          ),
          DayNightSwitcher(
            isDarkModeEnabled:
                Provider.of<GlobalValues>(context, listen: false).getFlag ??
                    false,
            onStateChanged: (isDarkModeEnabled) {
              Provider.of<GlobalValues>(context, listen: false).swapTheme();
            },
          ),
        ],
      ),
    );
  }
}
