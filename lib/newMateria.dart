import 'package:flutter/material.dart';
import 'package:dam_u3_appmateria/database.dart';
import 'package:dam_u3_appmateria/materia.dart';

class NewMateria extends StatefulWidget {
  const NewMateria({Key? key}) : super(key: key);

  @override
  State<NewMateria> createState() => _NewMateriaState();
}

class _NewMateriaState extends State<NewMateria> {
  final nombreMat = TextEditingController();
  final idMat = TextEditingController();
  final semesMat = TextEditingController();
  final docenMat = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Captura de Materia"),centerTitle: true,),
      body:  ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextField(decoration: InputDecoration(labelText: "IDMATERIA:"),controller: idMat, autofocus: true,),
            SizedBox(height: 40,),
            TextField(decoration: InputDecoration(labelText: "NOMBRE:"),controller: nombreMat,),
            SizedBox(height: 40,),
            TextField(decoration: InputDecoration(labelText: "DOCENTE:"),controller: docenMat,),
            SizedBox(height: 40,),
            TextField(decoration: InputDecoration(labelText: "SEMESTRE:"),controller: semesMat,),
            SizedBox(height: 40,),
            ElevatedButton(onPressed: (){
              Materia est = Materia(idmateria: idMat.text, semestre: semesMat.text,
                  nombre: nombreMat.text, docente: docenMat.text);
              DB.insertarMateria(est).then((value){
                if(value>0){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SE INSERTÓ CON EXITO")));
                  idMat.clear(); nombreMat.clear(); docenMat.clear(); semesMat.clear();
                }
              });
            }, child: Text("Agregar Materia"))
          ],
        ),

    );
  }
}
