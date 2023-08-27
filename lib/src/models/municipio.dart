class Municipio {
  int id;
  String nombre;
  int idProvicia;

  Municipio({
    required this.id,
    required this.nombre,
    required this.idProvicia,
  });

  Municipio fromJson(json) {
    return Municipio(
      id: json['id'],
      nombre: json['nombre'],
      idProvicia: json['idProvincia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'idProvicia': idProvicia,
    };
  }
}
