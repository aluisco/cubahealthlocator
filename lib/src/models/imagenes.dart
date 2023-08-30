import 'dart:convert';

class Imagenes {
  int id;
  String nombre;
  String descripcion;
  String photo;
  bool disponible;
  int institucion;

  Imagenes({
    required this.id,
    required this.nombre,
    required this.descripcion,
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
        descripcion: json["descripcion"],
        photo: json["photo"],
        disponible: json["disponible"],
        institucion: json["institucion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "photo": photo,
        "disponible": disponible,
        "institucion": institucion,
      };
}
