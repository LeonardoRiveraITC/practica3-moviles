import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/professor_model.dart';

class AddProfessor extends StatefulWidget {
  AddProfessor({super.key, this.professorModel});
  ProfessorModel? professorModel;
  @override
  State<AddProfessor> createState() => _AddProfessorState();
}

class _AddProfessorState extends State<AddProfessor> {
  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
    if (widget.professorModel != null) {
      txtConName.text = widget.professorModel!.nameProfessor!;
      txtConEmail.text = widget.professorModel!.email!;
      txtConCareer.text = widget.professorModel!.idCareer!.toString();
    }
  }

  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConEmail = TextEditingController();
  TextEditingController txtConCareer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final txtNameTask = TextFormField(
      decoration: const InputDecoration(
          label: Text('Profesor'), border: OutlineInputBorder()),
      controller: txtConName,
    );

    final txtEmailProfessor = TextFormField(
      decoration: const InputDecoration(
          label: Text('Email'), border: OutlineInputBorder()),
      controller: txtConEmail,
      maxLines: 6,
    );
    final txtCareer = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          label: Text('Carrera'), border: OutlineInputBorder()),
      controller: txtConCareer,
    );

    final space = SizedBox(height: 10);

    final ElevatedButton btnGuardar = ElevatedButton(
      child: Text('Save professor'),
      onPressed: () {
        if (widget.professorModel == null) {
          agendaDB!.INSERT('tblProfessor', {
            'nameProfessor': txtConName.text,
            'email': txtConEmail.text,
            'idCareer': txtConCareer.text
          }).then((value) {
            var msj = (value > 0) ? 'Insercion exitosa' : 'error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context);
          });
        } else {
          agendaDB!.UPDATE('tblProfessor', {
            'idProfessor': widget.professorModel!.idProfessor,
            'nameProfessor': txtConName.text,
            'email': txtConEmail.text,
            'idCareer': txtConCareer.text
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
        title: widget.professorModel == null
            ? Text('Add professor')
            : Text('Update professor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtNameTask,
            space,
            txtEmailProfessor,
            space,
            txtCareer,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }
}
