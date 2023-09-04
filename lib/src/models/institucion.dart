import 'dart:convert';

class Institucion {
  int id;
  String nombre;
  String direccion;
  String descripcion;
  String imagen;
  String longitud;
  String latitud;
  bool disponible;
  int provincia;
  int municipio;

  Institucion({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.descripcion,
    required this.imagen,
    required this.longitud,
    required this.latitud,
    required this.disponible,
    required this.provincia,
    required this.municipio,
  });

  factory Institucion.fromRawJson(String str) =>
      Institucion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Institucion.fromJson(Map<String, dynamic> json) => Institucion(
        id: json["id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        longitud: json["longitud"],
        latitud: json["latitud"],
        disponible: json["disponible"],
        provincia: json["provincia"],
        municipio: json["municipio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "descripcion": descripcion,
        "imagen": imagen,
        "longitud": longitud,
        "latitud": latitud,
        "disponible": disponible,
        "provincia": provincia,
        "municipio": municipio,
      };
}
