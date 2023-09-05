import 'package:flutter/material.dart';
import 'package:smcsalud/src/models/institucion.dart';
import 'package:smcsalud/src/pages/institucion.dart';
import 'package:smcsalud/src/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  AppLocalizations.of(context)!.address +
                      _filter[index].direccion,
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  backgroundColor: Colors.indigo,
                  title: Text(
                    _filter[index].nombre,
                    textAlign: TextAlign.center,
                  ),
                  content: SizedBox(
                    width: 300,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                            left: 20,
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                child: Image.network(
                                    '$site${_filter[index].imagen}'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocalizations.of(context)!.address +
                                    _filter[index].direccion,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                            ),
                            child: Text(AppLocalizations.of(context)!.goback),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return InstitucionPage(
                                      _filter[index].id,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.seedetails,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
