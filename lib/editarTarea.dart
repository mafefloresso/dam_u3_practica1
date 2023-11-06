import 'package:dam_u3_appmateria/database.dart';
import 'package:flutter/material.dart';
import 'package:dam_u3_appmateria/materia.dart';

class EditarTarea extends StatefulWidget {
  final Tarea tarea;
  final Function() onTareaEdit;

  EditarTarea({required this.tarea, required this.onTareaEdit});
  @override
  State<EditarTarea> createState() => _EditarTareaState();
}

class _EditarTareaState extends State<EditarTarea> {
  final f_entrega= TextEditingController();
  final descripcion= TextEditingController();
  String fecha_temp="";
  //idmateria idtarea
  @override
  void initState(){
    super.initState();
    fecha_temp=widget.tarea.f_entrega;
    f_entrega.text=widget.tarea.f_entrega;
    descripcion.text=widget.tarea.descripcion;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Actualizar Tarea"),),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Text("IDMATERIA: ${widget.tarea.idmateria} || IDTAREA: ${widget.tarea.idtarea.toString()}"),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("Fecha Entrega: ${fecha_temp}"),
              IconButton(onPressed: ()async{
                final DateTime? dateTime= await showDatePicker(
                    context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(3000));
                if(dateTime != null){
                  setState(() {
                    f_entrega.text="${dateTime.year}-${dateTime.month}-${dateTime.day}";
                    fecha_temp=f_entrega.text;
                  });
                }
              }, icon: Icon(Icons.calendar_month))
            ],
          ),
          SizedBox(height: 30,),
          TextField(
            controller: descripcion,
            decoration: InputDecoration(labelText: "Descripcion: "),
          ),
          ElevatedButton(onPressed: (){
            widget.tarea.f_entrega=f_entrega.text;
            widget.tarea.descripcion=descripcion.text;
            DB.actualizarTarea(widget.tarea).then((value){
              if(value>0){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SE ACTUALIZO CON EXITO")));
              }
            });
            Navigator.pop(context);
            widget.onTareaEdit();
          }, child: Text("ACTUALIZAR"))
        ],
      ),
    );
  }
}
