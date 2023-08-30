import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smcsalud/src/api/municipio_provider.dart';
import 'package:smcsalud/src/api/provincia_provider.dart';
import 'package:smcsalud/src/constants.dart';
import 'package:smcsalud/src/models/municipio.dart';
import 'package:smcsalud/src/models/provincia.dart';

class ProvinciaPage extends StatefulWidget {
  const ProvinciaPage(this.pid, {super.key});
  final int pid;

  @override
  State<ProvinciaPage> createState() => _ProvinciaPageState();
}

class _ProvinciaPageState extends State<ProvinciaPage> {
  late Future<Provincia> provinciaFuture;
  late Future<List<Municipio>> listMunicipioFuture;

  @override
  void initState() {
    provinciaFuture = getProvincia(widget.pid);
    listMunicipioFuture = getMunicipios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [provinciaFuture, listMunicipioFuture],
      ),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final provincia = snapshot.data![0];
          final municipios = snapshot.data![1]
              .where((propiedad) => propiedad.provincia == widget.pid)
              .toList();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                provincia.nombre,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/pbackground.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  child: Image.network(
                                      '$site${provincia.imagen}')),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                provincia.descripcion,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList.builder(
                        itemCount: municipios.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            title: Text(municipios[index].nombre),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
