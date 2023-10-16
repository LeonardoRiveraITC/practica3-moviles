import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/professor_model.dart';

import 'package:pmsn20232/widgets/CardProfessorWidget.dart';

class ProfessorScreen extends StatefulWidget {
  const ProfessorScreen({super.key});

  @override
  State<ProfessorScreen> createState() => _ProfessorScreen();
}

class _ProfessorScreen extends State<ProfessorScreen> {
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professor Manager'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/add_professor')
                  .then((value) => setState(() {})),
              icon: Icon(Icons.verified_user_sharp))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: GlobalValues.flagTask,
          builder: (context, value, _) {
            return FutureBuilder(
                future: agendaDB!.GETALLPROFESSOR(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProfessorModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardProfessorWidget(
                              professorModel: snapshot.data![index],
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
