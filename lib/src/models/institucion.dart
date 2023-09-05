import 'dart:convert';

class Institucion {
  int id;
  String nombre;
  String direccion;
  String descripcionEs;
  String descripcionEn;
  String imagen;
  bool disponible;
  int provincia;
  int municipio;

  Institucion({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.descripcionEs,
    required this.descripcionEn,
    required this.imagen,
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
        descripcionEs: json["descripcion_es"],
        descripcionEn: json["descripcion_en"],
        imagen: json["imagen"],
        disponible: json["disponible"],
        provincia: json["provincia"],
        municipio: json["municipio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "descripcion_es": descripcionEs,
        "descripcion_en": descripcionEn,
        "imagen": imagen,
        "disponible": disponible,
        "provincia": provincia,
        "municipio": municipio,
      };
}
