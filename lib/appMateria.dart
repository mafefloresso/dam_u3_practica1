
import 'package:dam_u3_appmateria/addTarea.dart';
import 'package:dam_u3_appmateria/newMateria.dart';
import 'package:dam_u3_appmateria/verMaterias.dart';
import 'package:dam_u3_appmateria/verTareas.dart';
import 'package:dam_u3_appmateria/verTareasHoy.dart';
import 'package:flutter/material.dart';

class AppMateria extends StatefulWidget {
  const AppMateria({Key? key}) : super(key: key);

  @override
  State<AppMateria> createState() => _AppMateriaState();
}

class _AppMateriaState extends State<AppMateria> {
  String materia = "";
  int _indice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(materia),
        centerTitle: true,
      ),
      body: dinamico(),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundColor: Colors.cyan,
                  radius: 20,
                  child: Text("TEC"),
                ),
                SizedBox(height: 20,),
                Text("Tecnologico de Tepic")
              ],

            ),decoration: BoxDecoration(color: Colors.pink),),
            _items("Materias", Icons.table_chart_outlined, 0),
            _items("Agregar Materias", Icons.add, 1),
            _items("Todas las Tareas", Icons.account_balance, 3),
            _items("Tareas de Hoy", Icons.content_paste_go, 4),
            _items("Agregar Tareas", Icons.add, 2),
          ],
        ),
      ),
    );
  }
  Widget _items(String descripcion, IconData icono, int index) {
    return InkWell(
      onTap: (){
        setState(() {
          _indice = index;
        });
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(child: Icon(icono),),
            Expanded(child: Text(descripcion), flex: 3,),
          ],
        ),
      ),
    );
  }
  dinamico() {
      switch(_indice){
        case 0:{
          return VerMaterias();
        }
        break;
        case 1:{
          return NewMateria();
        }
        break;
        case 2:{
          return AddTarea();
        }
        break;
        case 3:{
          return VerTareas();
        }
        break;
        case 4:{
          return VerTareasHoy();
        }
        default:
          return ListView();
      }
  }


}
