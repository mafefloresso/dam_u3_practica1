import 'package:dam_u3_appmateria/editarTarea.dart';
import 'package:flutter/material.dart';
import 'package:dam_u3_appmateria/database.dart';
import 'package:dam_u3_appmateria/materia.dart';

class VerTareas extends StatefulWidget {
  const VerTareas({Key? key}) : super(key: key);

  @override
  State<VerTareas> createState() => _VerTareasState();
}

class _VerTareasState extends State<VerTareas> {
  List<Tarea> tareas =[];

  void actualizarLista() async{
    List<Tarea> temporal = await DB.mostrarTodasTareas();
    setState(() {
      tareas=temporal;
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
      body: ListView.builder(
          itemCount: tareas.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditarTarea(
                    tarea: tareas[index], onTareaEdit:(){actualizarLista();} )));
              },
              child: ListTile(
                title: Text(tareas[index].f_entrega),
                subtitle: Text("${tareas[index].idmateria}  ${tareas[index].descripcion}"),
                trailing: IconButton(onPressed: (){
                  showDialog(context: context, builder: (BuildContext contex){
                    return AlertDialog(
                      title: Text("ELIMINAR MATERIA"),
                      content: Text("¿Desea eliminar esta materia ${tareas[index].descripcion}?"),
                      actions: [
                        TextButton(onPressed: (){Navigator.pop(context);}, child: Text("NO")),
                        TextButton(onPressed: (){
                          if (tareas[index].idtarea != null) {
                            DB.eliminarTarea(tareas[index].idtarea!).then((value) {
                              setState(() {
                                actualizarLista();
                              });
                            });
                          } else {
                            // Manejar el caso cuando idtarea es nulo, por ejemplo, mostrar un mensaje de error.
                          }
                          Navigator.pop(context);
                        }, child: Text("SI"))
                      ],
                    );
                  });
                }, icon: Icon(Icons.delete)),
              ),
            );
          }

      ),

    );
  }
}
