import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../database/agendadb.dart';

class CardTaskWidget extends StatefulWidget {
  CardTaskWidget({super.key, required this.taskModel,this.agendaDB});

  TaskModel taskModel;
  AgendaDB? agendaDB;

  @override
  State<CardTaskWidget> createState() => _CardTaskWidgetState();
}

class _CardTaskWidgetState extends State<CardTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.all(10),
      margin:EdgeInsets.only(top:10),
      decoration:BoxDecoration(
        color:Colors.green,
      ),
      child: Row(children: [
          Column(
            children: [
              Text(widget.taskModel.nameTask!),
              Text(widget.taskModel.dscTask!)
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [GestureDetector(onTap: () {
              showDialog(context: context,builder: (context){return AlertDialog(title: Text("Mensaje del sistema"),content: 
              Text("Deseas borrar"),
              actions: [
                TextButton(onPressed: (){
                  widget.agendaDB!.DELETE('tblTareas', widget.taskModel.idTask!).then((value) => Navigator.pop(context));
                }, child: Text("si")),
                TextButton(onPressed: (){Navigator.pop(context);}, child: Text("no"))]);});
            },child:Image.asset("/assets/naranja.png",height: 50)),
            IconButton(onPressed:(){},icon:Icon(Icons.delete))],
          )
      ],),
    );
  }
}