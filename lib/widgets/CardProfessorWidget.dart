import 'package:flutter/material.dart';
import 'package:pmsn20232/screens/add_professor.dart';

import '../models/professor_model.dart';
import '../database/agendadb.dart';

class CardProfessorWidget extends StatelessWidget {
  CardProfessorWidget({super.key, required this.professorModel, this.agendaDB});

  ProfessorModel professorModel;
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
              Text(professorModel.nameProfessor!),
              Text(professorModel.email!),
              Text("Carrera:  + ${professorModel.idCareer.toString()}"!)
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
                                builder: (context) => AddProfessor(
                                    professorModel: professorModel)))
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
              IconButton(onPressed: () {}, icon: Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
