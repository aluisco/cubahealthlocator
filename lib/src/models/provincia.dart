class Provincia {
  int id;
  String nombre;

  Provincia({
    required this.id,
    required this.nombre,
  });

  Provincia fromJson(json) {
    return Provincia(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
    };
  }
}
