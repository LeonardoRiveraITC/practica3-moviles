import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pmsn20232/models/task_model.dart';
import 'package:pmsn20232/models/professor_model.dart';
import 'package:pmsn20232/models/career_model.dart';
import 'package:pmsn20232/models/homework_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AgendaDB {
  static final nameDB = 'AGENDADB';
  static final versionDB = 1;

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(pathDB, version: versionDB, onCreate: _createTables);
  }

  FutureOr<void> _createTables(Database db, int version) {
    String query = '''
    CREATE TABLE tblTareas( 
      idTask INTEGER PRIMARY KEY,
      nameTask VARCHAR(50),
      dscTask VARCHAR(50),
      sttTask BYTE
    );
    CREATE TABLE tblCareer( 
      idCareer INTEGER PRIMARY KEY,
      nameCareer VARCHAR(50),
    );
    CREATE TABLE tblProfessor( 
      idProfessor INTEGER PRIMARY KEY,
      nameProfessor VARCHAR(50),
      idCareer INTEGER,
      email VARCHAR(50),
      FOREIGN KEY(idCareer) REFERENCES tblCareer(idCareer)
    );
    CREATE TABLE tblHomework( 
      idHomework INTEGER PRIMARY KEY,
      nameHomework VARCHAR(50),
      expireDate TEXT,
      notifyDate TEXT,
      descHomework VARCHAR(50),
      done INTEGER,
      idProfessor INTEGER,
      FOREIGN KEY(idProfesor) REFERENCES tblProfessor(idProfessor)
    );
    ''';
    db.execute(query);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idTask = ?', whereArgs: [data['idTask']]);
  }

  Future<int> DELETE(String tblName, int idTask) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'idTask = ?', whereArgs: [idTask]);
  }

  Future<List<TaskModel>> GETALLTASK() async {
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<int> UPDATEPROFESSOR(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idProfessor = ?', whereArgs: [data['idProfessor']]);
  }

  Future<int> DELETEPROFESSOR(String tblName, int idProfessor) async {
    var conexion = await database;
    return conexion!
        .delete(tblName, where: 'idProfessor = ?', whereArgs: [idProfessor]);
  }

  Future<List<ProfessorModel>> GETALLPROFESSOR() async {
    var conexion = await database;
    var result = await conexion!.query('tblProfessor');
    return result.map((task) => ProfessorModel.fromMap(task)).toList();
  }

  Future<int> UPDATECAREER(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idCareer = ?', whereArgs: [data['idCareer']]);
  }

  Future<int> DELETECAREER(String tblName, int idCareer) async {
    var conexion = await database;
    return conexion!
        .delete(tblName, where: 'idCareer = ?', whereArgs: [idCareer]);
  }

  Future<List<CareerModel>> GETALLCAREER() async {
    var conexion = await database;
    var result = await conexion!.query('tblProfessor');
    return result.map((task) => CareerModel.fromMap(task)).toList();
  }

  Future<int> UPDATEHOMEWORK(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idHomework = ?', whereArgs: [data['idHomework']]);
  }

  Future<int> DELETEHOMEWORK(String tblName, int idHomework) async {
    var conexion = await database;
    return conexion!
        .delete(tblName, where: 'idHomework = ?', whereArgs: [idHomework]);
  }

  Future<List<HomeworkModel>> GETALLHOMEWORK() async {
    var conexion = await database;
    var result = await conexion!.query('tblHomework');
    return result.map((task) => HomeworkModel.fromMap(task)).toList();
  }
}
