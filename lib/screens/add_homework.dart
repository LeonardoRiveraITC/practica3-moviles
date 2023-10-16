import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/homework_model.dart';
import 'package:intl/intl.dart';

class AddHomework extends StatefulWidget {
  AddHomework({super.key, this.homeworkModel});
  HomeworkModel? homeworkModel;
  @override
  State<AddHomework> createState() => _AddHomeworkState();
}

class _AddHomeworkState extends State<AddHomework> {
  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
    if (widget.homeworkModel != null) {
      txtConName.text = widget.homeworkModel!.nameHomework!;
      txtConDesc.text = widget.homeworkModel!.descHomework!;
      txtConStat.text = widget.homeworkModel!.done!.toString();
      txtConDue.text = widget.homeworkModel!.expireDate!;
      txtConRem.text = widget.homeworkModel!.notifyDate!;
      switch (widget.homeworkModel!.done) {
        case '1':
          dropDownValue = "En proceso";
          break;
        case '2':
          dropDownValue = "Completado";
          break;
        case '3':
        default:
          dropDownValue = "Pendiente";
          break;
      }
    }
  }

  String? dropDownValue = "Pendiente";
  List<String> dropDownValues = ['Pendiente', 'Completado', 'En proceso'];
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDesc = TextEditingController();
  TextEditingController txtConStat = TextEditingController();
  TextEditingController txtConDue = TextEditingController();
  TextEditingController txtConRem = TextEditingController();
  TextEditingController txtConProf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final txtNameHomework = TextFormField(
      decoration: const InputDecoration(
          label: Text('Tarea'), border: OutlineInputBorder()),
      controller: txtConName,
    );

    final txtDescHw = TextFormField(
      decoration: const InputDecoration(
          label: Text('Descripcion'), border: OutlineInputBorder()),
      controller: txtConDesc,
    );
    final DropdownButton ddBStatus = DropdownButton(
        value: dropDownValue,
        items: dropDownValues
            .map((status) =>
                DropdownMenuItem(value: status, child: Text(status)))
            .toList(),
        onChanged: (value) {
          dropDownValue = value;
          setState(() {});
        });
    final txtDescDue = TextFormField(
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          label: Text('Para'),
          border: OutlineInputBorder()),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(), //get today's date
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));
        if (pickedDate != null) {
          print(
              pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd H:m:s').format(
              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
          print(
              formattedDate); //formatted date output using intl package =>  2022-07-04
          //You can format date as per your need

          setState(() {
            txtConDue.text = formattedDate
                .toString(); //set foratted date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
      controller: txtConDue,
    );
    final txtDescRem = TextFormField(
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          label: Text('Recordar el'),
          border: OutlineInputBorder()),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(), //get today's date
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));
        if (pickedDate != null) {
          print(
              pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd H:m:s').format(
              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
          print(
              formattedDate); //formatted date output using intl package =>  2022-07-04
          //You can format date as per your need

          setState(() {
            txtConRem.text = formattedDate
                .toString(); //set foratted date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
      controller: txtConRem,
    );

    final txtProf = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          label: Text('Profesor'), border: OutlineInputBorder()),
      controller: txtConProf,
    );

    final space = SizedBox(height: 10);

    final ElevatedButton btnGuardar = ElevatedButton(
      child: Text('Save tarea'),
      onPressed: () {
        int storeState = 3;
        switch (dropDownValue.toString()) {
          case 'En proceso':
            storeState = 1;
            break;
          case 'Completado':
            storeState = 2;
            break;
        }
        if (widget.homeworkModel == null) {
          agendaDB!.INSERT('tblHomework', {
            'nameHomework': txtConName.text,
            'notifyDate': txtConRem.text,
            'descHomework': txtConDesc.text,
            'done': storeState.toString(),
            'expireDate': txtConDue.text,
            'idProfessor': txtConProf.text
          }).then((value) {
            var msj = (value > 0) ? 'Insercion exitosa' : 'error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context);
          });
        } else {
          agendaDB!.UPDATEHOMEWORK('tblHomework', {
            'idHomework': widget.homeworkModel!.idHomework,
            'nameHomework': txtConName.text,
            'expireDate': txtConDue.text,
            'notifyDate': txtConRem.text,
            'descHomework': txtConDesc.text,
            'done': storeState.toString(),
            'idProfessor': txtConProf.text
          }).then((value) {
            GlobalValues.flagProfessor.value =
                !GlobalValues.flagProfessor.value;
            var msj =
                (value > 0) ? 'La actualizacion fue exitosa' : 'Hubo un error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context);
          });
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: widget.homeworkModel == null
            ? Text('Add tarea')
            : Text('Update tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtNameHomework,
            space,
            ddBStatus,
            txtDescHw,
            space,
            txtDescDue,
            space,
            txtDescRem,
            space,
            txtProf,
            btnGuardar
          ],
        ),
      ),
    );
  }
}
