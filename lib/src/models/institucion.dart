class Institucion {
  int id;
  String nombre;
  String descripcion;
  int idProvincia;
  int idMunicipio;
  bool disponible;

  Institucion({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.idProvincia,
    required this.idMunicipio,
    required this.disponible,
  });

  Institucion fromJson(json) {
    return Institucion(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      idProvincia: json['idProvincia'],
      idMunicipio: json['idMunicipio'],
      disponible: json['disponible'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'idProvincia': idProvincia,
      'idMunicipio': idMunicipio,
      'disponible': disponible,
    };
  }
}
