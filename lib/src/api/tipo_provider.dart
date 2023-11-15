import 'dart:convert';
import 'package:lugares/src/models/tipo.dart';
import 'package:lugares/src/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<List<Tipo>> getTipos() async {
  final response = await http.get(
    Uri.parse('$site/api/tipo/'),
  );

  if (response.statusCode == 200) {
    List<Tipo> tipo = (json.decode(
      utf8.decode(response.bodyBytes),
    ) as List)
        .map(
          (data) => Tipo.fromJson(data),
        )
        .toList();
    return tipo;
  } else {
    throw Exception('Failed to load tipo');
  }
}

Future<Tipo> getTipo(int id) async {
  final response = await http.get(
    Uri.parse('$site/api/tipo/$id/'),
  );

  if (response.statusCode == 200) {
    return Tipo.fromJson(
      jsonDecode(
        utf8.decode(response.bodyBytes),
      ),
    );
  } else {
    throw Exception('Failed to load institution');
  }
}
