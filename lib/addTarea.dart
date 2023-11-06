import 'package:flutter/material.dart';
import 'package:dam_u3_appmateria/database.dart';
import 'package:dam_u3_appmateria/materia.dart';

class AddTarea extends StatefulWidget {
  const AddTarea({Key? key}) : super(key: key);

  @override
  State<AddTarea> createState() => _AddTareaState();
}

class _AddTareaState extends State<AddTarea> {
  DateTime selectedDate = DateTime.now();
  final fecha = TextEditingController();
  final desc =TextEditingController();
  final idMat = TextEditingController();
  String fechaadd= "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(decoration: InputDecoration(labelText: "DESCRIPCION:"),controller: desc,),
          SizedBox(height: 20,),
          TextField(decoration: InputDecoration(labelText: "idMat"), controller: idMat,),
          SizedBox(height: 20,),
          Row(children: [
            Text("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"),
            IconButton(onPressed: ()async{
              final DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(3000));
              if(dateTime != null){
                setState(() {
                  selectedDate =dateTime;
                  fechaadd = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                });
              }
            }, icon: Icon(Icons.calendar_month))
          ],),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
            Tarea est = Tarea(idmateria: idMat.text, descripcion: desc.text, f_entrega: fechaadd);
            DB.insertarTarea(est).then((value){
              if(value>0){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SE INSERTÓ CON EXITO")));
                idMat.clear(); desc.clear(); selectedDate=DateTime.now(); fechaadd="";
              }
            });
          }, child: Text("Insertar"))
        ],
      ),
    );
  }
}
