import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/career_model.dart';

import 'package:pmsn20232/widgets/CardCareerWidget.dart';

class CareerScreen extends StatefulWidget {
  const CareerScreen({super.key});

  @override
  State<CareerScreen> createState() => _CareerScreen();
}

class _CareerScreen extends State<CareerScreen> {
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
        title: Text('Career Manager'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/add_career')
                  .then((value) => setState(() {})),
              icon: Icon(Icons.verified_user_sharp))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: GlobalValues.flagCareer,
          builder: (context, value, _) {
            return FutureBuilder(
                future: agendaDB!.GETALLCAREER(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CareerModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardCareerWidget(
                              careerModel: snapshot.data![index],
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
