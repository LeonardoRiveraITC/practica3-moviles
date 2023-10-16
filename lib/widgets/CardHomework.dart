import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/screens/add_homework.dart';

import '../models/homework_model.dart';
import '../database/agendadb.dart';

class CardHomeworkWidget extends StatelessWidget {
  CardHomeworkWidget({super.key, required this.homeworkModel, this.agendaDB});

  HomeworkModel? homeworkModel;
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
              Text(homeworkModel!.nameHomework!),
              Text(homeworkModel!.descHomework!),
              Text("Estado : ${homeworkModel!.done}"),
              Text("Entregar en: ${homeworkModel!.expireDate}"),
              Text("Reduerdame en : ${homeworkModel!.notifyDate}")
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
                                    AddHomework(homeworkModel: homeworkModel)))
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
                                      .DELETEHOMEWORK('tblHomework',
                                          homeworkModel!.idHomework!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagHomework.value =
                                        !GlobalValues.flagHomework.value;
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
