import 'package:dam_u3_appmateria/editarMat.dart';

import 'materia.dart';
import 'package:dam_u3_appmateria/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class VerMaterias extends StatefulWidget {
  const VerMaterias({Key? key}) : super(key: key);

  @override
  State<VerMaterias> createState() => _VerMateriasState();
}

class _VerMateriasState extends State<VerMaterias> {
  final idMat = TextEditingController();
  final semestre= TextEditingController();
  final nombre= TextEditingController();
  final docente= TextEditingController();
  List<Materia> materias =[];
  Materia matGlobal = Materia(idmateria: "", semestre: "", nombre: "", docente: "");
  void actualizarLista() async{
    List<Materia> temporal = await DB.mostrarMateria();
    setState(() {
      materias=temporal;
    });
  }
  @override
  void initState(){
    super.initState();
    actualizarLista();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MATERIAS"),backgroundColor: Colors.green,centerTitle: true,),
      body:  ListView.builder(
            itemCount: materias.length,
            itemBuilder: (context,index){
              return InkWell(

                onTap: (){
                  matGlobal=materias[index];
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> EditarMat(
                    materia: materias[index], onMateriaEdit: (){actualizarLista();
                  },) ));
                },
                child: ListTile(
                  title: Text("${materias[index].idmateria} ${materias[index].nombre}"),
                  subtitle: Text(materias[index].docente),
                  trailing: IconButton(onPressed: (){
                    showDialog(context: context, builder: (BuildContext contex){
                      return AlertDialog(
                        title: Text("ELIMINAR MATERIA"),
                        content: Text("¿Desea eliminar esta materia ${materias[index].nombre}?"),
                        actions: [
                          TextButton(onPressed: (){Navigator.pop(context);}, child: Text("NO")),
                          TextButton(onPressed: (){
                            DB.eliminarMateria(materias[index].idmateria).then((value){
                              setState(() {
                                actualizarLista();
                              });
                            });
                            Navigator.pop(context);
                          }, child: Text("SI"))
                        ],
                      );
                    });
                  },icon: Icon(Icons.delete),),
                ),
              );
            }),

    );
  }

}
