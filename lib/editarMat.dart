import 'package:dam_u3_appmateria/database.dart';
import 'package:flutter/material.dart';
import 'package:dam_u3_appmateria/materia.dart';
import 'package:dam_u3_appmateria/appMateria.dart';

class EditarMat extends StatefulWidget {
  final Materia materia;
  final Function() onMateriaEdit;
  EditarMat({required this.materia, required this.onMateriaEdit});
  @override
  State<EditarMat> createState() => _EditarMatState();
}

class _EditarMatState extends State<EditarMat> {
  final nombre = TextEditingController();
  final semestre = TextEditingController();
  final docente = TextEditingController();
  @override
  void initState() {
    super.initState();
    nombre.text = widget.materia.nombre;
    semestre.text = widget.materia.semestre;
    docente.text = widget.materia.docente;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Actualizar Materia"),),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Text("IDMATERIA: ${widget.materia.idmateria}", style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          TextField(
            controller: nombre,
            decoration: InputDecoration(labelText: "Nombre Materia: "),
          ),
          SizedBox(height: 20),
          TextField(
            controller: semestre,
            decoration: InputDecoration(labelText: "Semestre: "),
          ),
          SizedBox(height: 20),
          TextField(
            controller: docente,
            decoration: InputDecoration(labelText: "Docente: "),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.materia.nombre=nombre.text;
              widget.materia.semestre=semestre.text;
              widget.materia.docente=docente.text;
              DB.actualizarMateria(widget.materia).then((value) {
                if(value>0){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SE ACTUALIZO CON EXITO")));
                }
              });
              Navigator.pop(context);
              widget.onMateriaEdit();
            },
            child: Text("ACTUALIZAR"),
          ),
        ],
      ),
    );
  }
}