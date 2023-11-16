import 'dart:convert';
import 'package:lugares/src/utils/constants.dart';
import 'package:lugares/src/models/municipio.dart';
import 'package:http/http.dart' as http;

Future<List<Municipio>> getMunicipios() async {
  final response = await http.get(Uri.parse('$site/api/municipio/'));

  if (response.statusCode == 200) {
    List<Municipio> municipio =
        (json.decode(utf8.decode(response.bodyBytes)) as List)
            .map((data) => Municipio.fromJson(data))
            .toList();
    return municipio;
  } else {
    throw Exception('Failed to load');
  }
}

Future<Municipio> getMunicipio(int id) async {
  final response = await http.get(Uri.parse('$site/api/municipio/$id/'));

  if (response.statusCode == 200) {
    return Municipio.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load');
  }
}
