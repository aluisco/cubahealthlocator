import 'dart:ui';
import 'dart:io' show Platform;
import 'package:android_intent_plus/android_intent.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smcsalud/src/api/imagenes_provider.dart';
import 'package:smcsalud/src/api/institucion_provider.dart';
import 'package:smcsalud/src/utils/constants.dart';
import 'package:smcsalud/src/models/imagenes.dart';
import 'package:smcsalud/src/models/institucion.dart';
import 'package:smcsalud/src/utils/loading.dart';
import 'package:smcsalud/src/utils/search.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InstitucionPage extends StatefulWidget {
  const InstitucionPage(this.iid, {super.key});
  final int iid;

  @override
  State<InstitucionPage> createState() => _InstitucionPageState();
}

class _InstitucionPageState extends State<InstitucionPage> {
  late Future<Institucion> institucionFuture;
  late Future<List<Imagenes>> listImagenesFuture;
  late Future<List<Institucion>> listInstitucionFuture;

  @override
  void initState() {
    institucionFuture = getInstitucion(widget.iid);
    listInstitucionFuture = getInstituciones();
    listImagenesFuture = getImagenes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [institucionFuture, listImagenesFuture, listInstitucionFuture],
      ),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        final Locale locale = Localizations.localeOf(context);
        if (snapshot.hasData && snapshot.data != null) {
          final institucion = snapshot.data![0];
          final imagenes = snapshot.data![1]
              .where((propiedad) => propiedad.institucion == widget.iid)
              .toList();
          final instituciones = snapshot.data![2];
          final String institucionDescrip;
          if (locale.languageCode == 'es') {
            institucionDescrip = institucion.descripcionEs;
          } else {
            institucionDescrip = institucion.descripcionEn;
          }
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                institucion.nombre,
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
                      delegate: SearchInstitucion(instituciones,
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
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage('assets/img/pinst.jpg'),
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
                                          '$site${institucion.imagen}'),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.address +
                                          institucion.direccion,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      institucionDescrip,
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
                                    Text(
                                      AppLocalizations.of(context)!.services,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
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
                                itemCount: imagenes.length,
                                itemBuilder: (BuildContext context,
                                    int itemIndex, int pageViewIndex) {
                                  return GestureDetector(
                                    onTap: () {
                                      showGeneralDialog(
                                        barrierDismissible: true,
                                        barrierLabel: '',
                                        barrierColor: Colors.black12,
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        pageBuilder: (ctx, anim1, anim2) =>
                                            AlertDialog(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(25.0),
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.only(top: 10.0),
                                          backgroundColor: Colors.black38,
                                          title:
                                              Text(imagenes[itemIndex].nombre),
                                          content: SizedBox(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(15),
                                                        ),
                                                        child: Image.network(
                                                            '$site${imagenes[itemIndex].photo}'),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      if (locale.languageCode ==
                                                          'es')
                                                        Text(
                                                          imagenes[itemIndex]
                                                              .descripcionEs,
                                                        ),
                                                      if (locale.languageCode ==
                                                          'en')
                                                        Text(
                                                          imagenes[itemIndex]
                                                              .descripcionEn,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text('OK'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        transitionBuilder:
                                            (ctx, anim1, anim2, child) =>
                                                BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 4 * anim1.value,
                                              sigmaY: 4 * anim1.value),
                                          child: FadeTransition(
                                            opacity: anim1,
                                            child: child,
                                          ),
                                        ),
                                        context: context,
                                      );
                                    },
                                    child: ListView(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                          child: Image.network(
                                            '$site${imagenes[itemIndex].photo}',
                                            fit: BoxFit.cover,
                                            height: 205,
                                          ),
                                        ),
                                      ],
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
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.indigo,
              onPressed: () async {
                String destination =
                    Uri.encodeComponent('${institucion.direccion}');
                if (Platform.isAndroid) {
                  final AndroidIntent intent = AndroidIntent(
                      action: 'action_view',
                      data:
                          "https://www.google.com/maps/search/?api=1&query=$destination",
                      package: 'com.google.android.apps.maps');
                  intent.launch();
                } else if (Platform.isIOS) {
                  String urlAppleMaps =
                      'http://maps.apple.com/?daddr=$destination&dirflg=d&t=h';
                  if (await canLaunchUrlString(urlAppleMaps)) {
                    await launchUrlString(urlAppleMaps);
                  } else {
                    throw 'Could not launch $urlAppleMaps';
                  }
                }
              },
              icon: const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              label: Text(
                AppLocalizations.of(context)!.location,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BottomAppBar(
              color: Colors.indigo,
              shape: const AutomaticNotchedShape(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
              notchMargin: 8,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  'Copyright © SMC 2023',
                  style: GoogleFonts.abel(),
                ),
              ),
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
