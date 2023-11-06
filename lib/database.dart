import 'package:dam_u3_appmateria/appMateria.dart';
import 'package:dam_u3_appmateria/materia.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {

  static Future<Database> _abrirBD() async {
    return openDatabase(
      join(await getDatabasesPath(), "practica1.db"),
      onCreate: (db, version) {
        return db.transaction((txn) async {
          await txn.execute(
              "CREATE TABLE MATERIA(IDMATERIA TEXT PRIMARY KEY, NOMBRE TEXT, SEMESTRE TEXT, DOCENTE TEXT)");
          await txn.execute(
              "CREATE TABLE TAREA(IDTAREA INTEGER PRIMARY KEY AUTOINCREMENT, IDMATERIA TEXT, F_ENTREGA TEXT, DESCRIPCION TEXT, FOREIGN KEY (IDMATERIA) REFERENCES MATERIA(IDMATERIA))");
        });
      },
      version: 1,
    );
  }

  static Future<int> insertarMateria(Materia m) async{
    Database db = await _abrirBD();
    return db.insert("MATERIA", m.toJSON(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> insertarTarea(Tarea t) async{
    Database db = await _abrirBD();
    t.idtarea=null;
    return db.insert("TAREA", t.toJSON(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Materia>> mostrarMateria() async{
    Database db= await _abrirBD();

    List<Map<String,dynamic>> resultado = await db.query("MATERIA");

    return List.generate(resultado.length, (index){
      return Materia(idmateria: resultado[index]['IDMATERIA'], semestre: resultado[index]['SEMESTRE'], nombre: resultado[index]['NOMBRE'],
          docente: resultado[index]['DOCENTE']);
    });
  }

  static Future<List<Tarea>> mostrarTodasTareas() async{
    Database db= await _abrirBD();

    List<Map<String,dynamic>> resultado = await db.query("TAREA");

    return List.generate(resultado.length, (index){
      return Tarea(idmateria: resultado[index]['IDMATERIA'], descripcion: resultado[index]['DESCRIPCION'],
          f_entrega: resultado[index]['F_ENTREGA'], idtarea: resultado[index]['IDTAREA']);
    });
  }

  static Future<List<Tarea>> mostrarTarea() async{
    Database db= await _abrirBD();
    DateTime currentDate = DateTime.now();
    List<Map<String,dynamic>> resultado = await db.query("TAREA",where: "F_ENTREGA=?",whereArgs: ["${currentDate.year}-${currentDate.month}-${currentDate.day}"]);
    return List.generate(resultado.length, (index){
      return Tarea(idmateria: resultado[index]['IDMATERIA'], descripcion: resultado[index]['DESCRIPCION'],
          f_entrega: resultado[index]['F_ENTREGA'], idtarea: resultado[index]['IDTAREA']);
    });
  }

  static Future<int> eliminarTarea(int valor) async{
    Database db= await _abrirBD();
    return db.delete("TAREA", where: "IDTAREA=?", whereArgs: [valor]);
  }

  static Future<void> eliminarMateria(String valor)async{
    Database db= await _abrirBD();
    return db.transaction((txn)async{
      await txn.delete("TAREA", where: "IDMATERIA=?", whereArgs: [valor]);
      await txn.delete("MATERIA", where: "IDMATERIA=?", whereArgs: [valor]);
    });
  }

  static Future<int> actualizarMateria(Materia e) async{
    Database db= await _abrirBD();
    return db.update("MATERIA", e.toJSON(), where: "IDMATERIA=?", whereArgs: [e.idmateria]);
  }

  static Future<int> actualizarTarea(Tarea e)async{
    Database db=await _abrirBD();
    return db.update("TAREA", e.toJSON(), where:"IDTAREA=?",whereArgs: [e.idtarea]);
  }


}