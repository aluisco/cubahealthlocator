import 'dart:convert';
import 'package:smcsalud/src/utils/constants.dart';
import 'package:smcsalud/src/models/imagenes.dart';
import 'package:http/http.dart' as http;

Future<List<Imagenes>> getImagenes() async {
  final response = await http.get(Uri.parse('$site/api/imagenes/'));

  if (response.statusCode == 200) {
    List<Imagenes> imagenes =
        (json.decode(utf8.decode(response.bodyBytes)) as List)
            .map((data) => Imagenes.fromJson(data))
            .toList();
    return imagenes;
  } else {
    throw Exception('Failed to load images');
  }
}

Future<Imagenes> getImagen(int id) async {
  final response = await http.get(Uri.parse('$site/api/imagenes/$id/'));

  if (response.statusCode == 200) {
    return Imagenes.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load image');
  }
}
