import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB=AgendaDB();
  }  
    String dropDownValue = "Pendiente";
    List<String> dropDownValues = [
      'Pendiente',
      'Completado',
      'En proceso'
    ];
    TextEditingController txtConName = TextEditingController();
    TextEditingController txtConDsc = TextEditingController();
  @override
  Widget build(BuildContext context) {

    
    final txtNameTask = TextFormField(
      decoration: const InputDecoration(label:Text('Tarea'),border: OutlineInputBorder()),
      controller: txtConName,
    );

    final txtDscTask = TextFormField(
      decoration: const InputDecoration(label:Text('Descripcion'),border: OutlineInputBorder()),
      controller: txtConDsc,
      maxLines:6,
    );


    final space=SizedBox(height: 10);

    final DropdownButton ddBStatus = DropdownButton(
      value: dropDownValue,
      items: dropDownValues.map(
        (status) => DropdownMenuItem(
          value: status,
          child: Text(status)
        )
      ).toList(),  
      onChanged: (value){
        dropDownValue = value;
        setState(() {});
      }
    );
    final ElevatedButton btnGuardar=ElevatedButton(child:Text('Save task'), onPressed: (){
      agendaDB!.INSERT('tblTareas', {
          'nameTask':txtConName.text,
          'dscTask':txtConDsc.text,
          'sttTask':dropDownValue.substring(1,1)
      }).then((value){
        var msj =  (value>0) ? 'Insercion exitosa' : 'error';
        var snackbar = SnackBar(content: Text(msj));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Navigator.pop(context);
      });
    },);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtNameTask,
            space,
            txtDscTask,
            space,
            ddBStatus,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }
}