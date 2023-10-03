import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lugares/src/api/institucion_provider.dart';
import 'package:lugares/src/api/municipio_provider.dart';
import 'package:lugares/src/utils/arrows.dart';
import 'package:lugares/src/utils/constants.dart';
import 'package:lugares/src/models/institucion.dart';
import 'package:lugares/src/models/municipio.dart';
import 'package:lugares/src/pages/institucion.dart';
import 'package:lugares/src/utils/faderoute.dart';
import 'package:lugares/src/utils/footer.dart';
import 'package:lugares/src/utils/loading.dart';
import 'package:lugares/src/utils/search.dart';
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
  bool more = false;

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
                              padding: const EdgeInsets.all(15.0),
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
                                    textAlign: TextAlign.justify,
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
                                height: 265,
                                aspectRatio: 1.5,
                                viewportFraction: 0.8,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.scale,
                                autoPlay: false,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                                enableInfiniteScroll: false,
                              ),
                              itemCount: instituciones.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                if (instituciones.length > 1) {
                                  more = true;
                                }
                                return Material(
                                  elevation: 8,
                                  borderRadius: BorderRadius.circular(15),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white54,
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.indigo,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          FadeRoute(
                                            page: InstitucionPage(
                                              instituciones[itemIndex].id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        color: Colors.indigoAccent,
                                        clipBehavior: Clip.hardEdge,
                                        child: Wrap(
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  constraints:
                                                      BoxConstraints.loose(
                                                    const Size.fromHeight(225),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          '$site${instituciones[itemIndex].imagen}'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  transform:
                                                      Matrix4.translationValues(
                                                          0.1, -10.0, 0.1),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.indigoAccent,
                                                    border: Border.all(
                                                        color: Colors.indigo,
                                                        width:
                                                            1.0), // Set border width
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ), // Set rounded corner radius
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        blurRadius: 15,
                                                        color: Colors.black,
                                                        offset: Offset(1, 3),
                                                      ),
                                                    ], // Make rounded corner of border
                                                  ),
                                                  child: Text(
                                                    instituciones[itemIndex]
                                                        .nombre,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (more) const ArrowsPage(),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const FooterPage(),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Loading();
      },
    );
  }
}
