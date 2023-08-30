import 'dart:convert';

class Provincia {
  int id;
  String nombre;
  String descripcion;
  String imagen;

  Provincia({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
  });

  factory Provincia.fromRawJson(String str) =>
      Provincia.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Provincia.fromJson(Map<String, dynamic> json) => Provincia(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "imagen": imagen,
      };
}
