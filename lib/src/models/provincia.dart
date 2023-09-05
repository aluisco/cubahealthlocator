import 'dart:convert';

class Provincia {
  int id;
  String nombre;
  String descripcionEs;
  String descripcionEn;
  String imagen;

  Provincia({
    required this.id,
    required this.nombre,
    required this.descripcionEs,
    required this.descripcionEn,
    required this.imagen,
  });

  factory Provincia.fromRawJson(String str) =>
      Provincia.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Provincia.fromJson(Map<String, dynamic> json) => Provincia(
        id: json["id"],
        nombre: json["nombre"],
        descripcionEs: json["descripcion_es"],
        descripcionEn: json["descripcion_en"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion_es": descripcionEs,
        "descripcion_en": descripcionEn,
        "imagen": imagen,
      };
}
