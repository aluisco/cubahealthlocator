class Provincia {
  int id;
  String nombre;

  Provincia({
    required this.id,
    required this.nombre,
  });

  factory Provincia.fromJson(Map<String, dynamic> json) => Provincia(
        id: json['id'],
        nombre: json['nombre'],
      );

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
      };
}
