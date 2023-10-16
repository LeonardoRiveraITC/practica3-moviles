import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/screens/add_career.dart';

import '../models/career_model.dart';
import '../database/agendadb.dart';

class CardCareerWidget extends StatelessWidget {
  CardCareerWidget({super.key, required this.careerModel, this.agendaDB});

  CareerModel careerModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(careerModel.nameCareer!),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddCareer(careerModel: careerModel)))
                      },
                  /*
              showDialog(context: context,builder: (context){return AlertDialog(title: Text("Mensaje del sistema"),content: 
              Text("Deseas borrar"),
              actions: [
                TextButton(onPressed: (){
                  widget.agendaDB!.DELETE('tblTareas', widget.taskModel.idTask!).then((value) => Navigator.pop(context));
                }, child: Text("si")),
                TextButton(onPressed: (){Navigator.pop(context);}, child: Text("no"))]);});
            },*/
                  child: Image.asset("assets/naranja.png", height: 50)),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Mensaje del sistema'),
                          content: Text('¿Deseas borrar la tarea?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  agendaDB!
                                      .DELETECAREER(
                                          'tblCareer', careerModel.idCareer!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagCareer.value =
                                        !GlobalValues.flagCareer.value;
                                  });
                                },
                                child: Text('Si')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No')),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
