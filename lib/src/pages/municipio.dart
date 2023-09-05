import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smcsalud/src/api/institucion_provider.dart';
import 'package:smcsalud/src/api/municipio_provider.dart';
import 'package:smcsalud/src/utils/constants.dart';
import 'package:smcsalud/src/models/institucion.dart';
import 'package:smcsalud/src/models/municipio.dart';
import 'package:smcsalud/src/pages/institucion.dart';
import 'package:smcsalud/src/utils/loading.dart';
import 'package:smcsalud/src/utils/search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MunicipioPage extends StatefulWidget {
  const MunicipioPage(this.mid, {super.key});
  final int mid;

  @override
  State<MunicipioPage> createState() => _MunicipioPageState();
}

class _MunicipioPageState extends State<MunicipioPage> {
  late Future<Municipio> municipioFuture;
  late Future<List<Institucion>> listInstitucionFuture;

  @override
  void initState() {
    municipioFuture = getMunicipio(widget.mid);
    listInstitucionFuture = getInstituciones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [municipioFuture, listInstitucionFuture],
      ),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        final Locale locale = Localizations.localeOf(context);
        if (snapshot.hasData && snapshot.data != null) {
          final municipio = snapshot.data![0];
          final instituciones = snapshot.data![1]
              .where((propiedad) => propiedad.municipio == widget.mid)
              .toList();
          final String municipioDescrip;
          if (locale.languageCode == 'es') {
            municipioDescrip = municipio.descripcionEs;
          } else {
            municipioDescrip = municipio.descripcionEn;
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                municipio.nombre,
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
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: SearchInstitucion(snapshot.data![1],
                          AppLocalizations.of(context)!.searchinst),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage('assets/img/pxfuel.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white60,
                        Colors.transparent
                      ],
                      stops: [0, 0.7, 1],
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
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
                                          '$site${municipio.imagen}')),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    municipioDescrip,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
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
                          SliverToBoxAdapter(
                            child: CarouselSlider.builder(
                              options: CarouselOptions(
                                aspectRatio: 1.5,
                                viewportFraction: 0.8,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                autoPlay: false,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                                enableInfiniteScroll: false,
                              ),
                              itemCount: instituciones.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return InstitucionPage(
                                            instituciones[itemIndex].id,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: 300.0,
                                    height: 300.0,
                                    child: Card(
                                      shadowColor: Colors.greenAccent,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                      child: ListView(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                            ),
                                            child: Image.network(
                                              '$site${instituciones[itemIndex].imagen}',
                                              fit: BoxFit.cover,
                                              height: 205,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            instituciones[itemIndex].nombre,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Loading();
      },
    );
  }
}
