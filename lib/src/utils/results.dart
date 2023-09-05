import 'package:flutter/material.dart';
import 'package:smcsalud/src/models/institucion.dart';
import 'package:smcsalud/src/utils/constants.dart';

class Results extends StatelessWidget {
  const Results(this._filter, {super.key});
  final List<Institucion> _filter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (_, index) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: Image.network('$site${_filter[index].imagen}'),
          ),
          title: Text(_filter[index].nombre),
          subtitle: Row(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  'Dirección: ${_filter[index].direccion}',
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(_filter[index].nombre),
                  content: const Text('Contenido de Precios y demás!'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK')),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
