import 'dart:convert';

class Imagenes {
  int id;
  String nombre;
  String descripcionEs;
  String descripcionEn;
  String photo;
  bool disponible;
  int institucion;

  Imagenes({
    required this.id,
    required this.nombre,
    required this.descripcionEs,
    required this.descripcionEn,
    required this.photo,
    required this.disponible,
    required this.institucion,
  });

  factory Imagenes.fromRawJson(String str) =>
      Imagenes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Imagenes.fromJson(Map<String, dynamic> json) => Imagenes(
        id: json["id"],
        nombre: json["nombre"],
        descripcionEs: json["descripcion_es"],
        descripcionEn: json["descripcion_en"],
        photo: json["photo"],
        disponible: json["disponible"],
        institucion: json["institucion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion_es": descripcionEs,
        "descripcion_en": descripcionEn,
        "photo": photo,
        "disponible": disponible,
        "institucion": institucion,
      };
}
