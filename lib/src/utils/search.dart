import 'package:flutter/material.dart';
import 'package:cubahealthlocator/src/models/institucion.dart';
import 'package:cubahealthlocator/src/utils/notfound.dart';
import 'package:cubahealthlocator/src/utils/results.dart';

class SearchInstitucion extends SearchDelegate<Institucion> {
  List<Institucion> _filter = [];
  final List<Institucion> instituciones;
  final String? hintText;

  SearchInstitucion(this.instituciones, this.hintText);

  @override
  String? get searchFieldLabel => hintText;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.indigo,
      ),
      hintColor: Colors.white,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.blueAccent,
        selectionHandleColor: Colors.blueAccent,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back),
    );
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    if (_filter.isEmpty) {
      return const NotFound();
    } else {
      return Results(_filter);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = instituciones
        .where((institucion) => institucion.nombre.toLowerCase().contains(
              query.trim().toLowerCase(),
            ))
        .toList();
    if (_filter.isEmpty) {
      return const NotFound();
    } else {
      return Results(_filter);
    }
  }
}
