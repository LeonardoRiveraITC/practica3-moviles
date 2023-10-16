import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/career_model.dart';

class AddCareer extends StatefulWidget {
  AddCareer({super.key, this.careerModel});
  CareerModel? careerModel;
  @override
  State<AddCareer> createState() => _AddCareerState();
}

class _AddCareerState extends State<AddCareer> {
  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
    if (widget.careerModel != null) {
      txtConName.text = widget.careerModel!.nameCareer!;
    }
  }

  TextEditingController txtConName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final txtNameTask = TextFormField(
      decoration: const InputDecoration(
          label: Text('Carrera'), border: OutlineInputBorder()),
      controller: txtConName,
    );

    final space = SizedBox(height: 10);

    final ElevatedButton btnGuardar = ElevatedButton(
      child: Text('Save career'),
      onPressed: () {
        if (widget.careerModel == null) {
          agendaDB!.INSERT('tblCareer', {'nameCareer': txtConName.text}).then(
              (value) {
            var msj = (value > 0) ? 'Insercion exitosa' : 'error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context);
          });
        } else {
          agendaDB!.UPDATECAREER('tblCareer', {
            'idCareer': widget.careerModel!.idCareer,
            'nameCareer': txtConName.text
          }).then((value) {
            GlobalValues.flagCareer.value = !GlobalValues.flagCareer.value;
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
        title: widget.careerModel == null
            ? Text('Add careeer')
            : Text('Update career'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [txtNameTask, space, btnGuardar],
        ),
      ),
    );
  }
}
