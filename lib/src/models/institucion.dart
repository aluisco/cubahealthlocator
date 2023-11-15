import 'dart:convert';

class Institucion {
  int id;
  String nombre;
  String direccion;
  String descripcionEs;
  String descripcionEn;
  String imagen;
  String phone;
  bool urgencia;
  bool disponible;
  int provincia;
  int municipio;
  int tipo;

  Institucion({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.descripcionEs,
    required this.descripcionEn,
    required this.imagen,
    required this.phone,
    required this.urgencia,
    required this.disponible,
    required this.provincia,
    required this.municipio,
    required this.tipo,
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
        phone: json["phone"],
        urgencia: json["urgencia"],
        disponible: json["disponible"],
        provincia: json["provincia"],
        municipio: json["municipio"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "descripcion_es": descripcionEs,
        "descripcion_en": descripcionEn,
        "imagen": imagen,
        "phone": phone,
        "urgencia": urgencia,
        "disponible": disponible,
        "provincia": provincia,
        "municipio": municipio,
        "tipo": tipo,
      };
}
