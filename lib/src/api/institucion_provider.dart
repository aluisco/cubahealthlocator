import 'dart:convert';
import 'package:cubahealthlocator/src/utils/constants.dart';
import 'package:cubahealthlocator/src/models/institucion.dart';
import 'package:http/http.dart' as http;

Future<List<Institucion>> getInstituciones() async {
  final response = await http.get(Uri.parse('$site/api/institucion/'));

  if (response.statusCode == 200) {
    List<Institucion> institucion = (json.decode(
      utf8.decode(response.bodyBytes),
    ) as List)
        .map((data) => Institucion.fromJson(data))
        .toList();
    return institucion;
  } else {
    throw Exception('Failed to load institutions');
  }
}

Future<Institucion> getInstitucion(int id) async {
  final response = await http.get(Uri.parse('$site/api/institucion/$id/'));

  if (response.statusCode == 200) {
    return Institucion.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load institution');
  }
}
