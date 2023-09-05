import 'dart:convert';

class Municipio {
  int id;
  String nombre;
  String descripcionEs;
  String descripcionEn;
  String imagen;
  int provincia;

  Municipio({
    required this.id,
    required this.nombre,
    required this.descripcionEs,
    required this.descripcionEn,
    required this.imagen,
    required this.provincia,
  });

  factory Municipio.fromRawJson(String str) =>
      Municipio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Municipio.fromJson(Map<String, dynamic> json) => Municipio(
        id: json["id"],
        nombre: json["nombre"],
        descripcionEs: json["descripcion_es"],
        descripcionEn: json["descripcion_en"],
        imagen: json["imagen"],
        provincia: json["provincia"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion_es": descripcionEs,
        "descripcion_en": descripcionEn,
        "imagen": imagen,
        "provincia": provincia,
      };
}
