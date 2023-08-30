import 'dart:convert';

class Municipio {
  int id;
  String nombre;
  String descripcion;
  String imagen;
  int provincia;

  Municipio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.provincia,
  });

  factory Municipio.fromRawJson(String str) =>
      Municipio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Municipio.fromJson(Map<String, dynamic> json) => Municipio(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        provincia: json["provincia"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "imagen": imagen,
        "provincia": provincia,
      };
}
