import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/homework_model.dart';

import 'package:pmsn20232/widgets/CardHomework.dart';

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({super.key});

  @override
  State<HomeworkScreen> createState() => _HomeworkScreen();
}

class _HomeworkScreen extends State<HomeworkScreen> {
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  TextEditingController txtConSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homework Manager'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/add_homework')
                  .then((value) => setState(() {})),
              icon: Icon(Icons.verified_user_sharp))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: GlobalValues.flagHomework,
          builder: (context, value, _) {
            return FutureBuilder(
                future: agendaDB!.GETALLHOMEWORK(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<HomeworkModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardHomeworkWidget(
                              homeworkModel: snapshot.data![index],
                              agendaDB: agendaDB);
                        });
                  } else {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error!'),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
                });
          }),
    );
  }
}
