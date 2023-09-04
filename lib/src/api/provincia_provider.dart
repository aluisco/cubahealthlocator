import 'dart:convert';
import 'package:smcsalud/src/utils/constants.dart';
import 'package:smcsalud/src/models/provincia.dart';
import 'package:http/http.dart' as http;

Future<List<Provincia>> getProvincias() async {
  final response = await http.get(Uri.parse('$site/api/provincia/'));

  if (response.statusCode == 200) {
    List<Provincia> provincia =
        (json.decode(utf8.decode(response.bodyBytes)) as List)
            .map((data) => Provincia.fromJson(data))
            .toList();
    return provincia;
  } else {
    throw Exception('Failed to load provinces');
  }
}

Future<Provincia> getProvincia(int id) async {
  final response = await http.get(Uri.parse('$site/api/provincia/$id/'));

  if (response.statusCode == 200) {
    return Provincia.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load province');
  }
}
