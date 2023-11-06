class Materia {
 String idmateria;
 String nombre;
 String semestre;
 String docente;

 Materia({
     required this.idmateria,
     required this.semestre,
     required this.nombre,
     required this.docente,
  });
    Map<String, dynamic> toJSON(){
      return{
      'idmateria':idmateria,
        'semestre':semestre,
        'nombre':nombre,
        'docente':docente
      };
    }
}

class Tarea{
  int? idtarea;
  String idmateria;
  String f_entrega;
  String descripcion;

  Tarea({
    required this.idmateria, required this.descripcion, required this.f_entrega,  this.idtarea
});
  Map<String, dynamic> toJSON(){
    return{
      'idmateria':idmateria,
      'descripcion':descripcion,
      'f_entrega':f_entrega,
      'idtarea':idtarea
    };
  }
}