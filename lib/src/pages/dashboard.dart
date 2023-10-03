import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugares/src/api/institucion_provider.dart';
import 'package:lugares/src/api/provincia_provider.dart';
import 'package:lugares/src/models/institucion.dart';
import 'package:lugares/src/utils/arrows.dart';
import 'package:lugares/src/utils/constants.dart';
import 'package:lugares/src/models/provincia.dart';
import 'package:lugares/src/pages/provincia.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lugares/src/utils/faderoute.dart';
import 'package:lugares/src/utils/search.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  late Future<List<Provincia>> listProvincias;
  late AnimationController controller;
  late Animation<double> animation;

  Locale? _locale;
  @override
  void initState() {
    listProvincias = getProvincias();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setLocale(context),
    );
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    setState(() {
      _locale = locales?.first ?? _locale;
    });
  }

  setLocale(BuildContext context) {
    final Locale locale = Localizations.localeOf(context);
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.indigo,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              contentPadding: const EdgeInsets.all(20.0),
              title: Center(
                child: Text(
                  AppLocalizations.of(context)!.exit,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.reallyexit,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: Text(AppLocalizations.of(context)!.no),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(
                        AppLocalizations.of(context)!.yes,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            AppLocalizations.of(context)!.dashboardTitle,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final List<Institucion> listInstituciones = [];
                final data = await getInstituciones();
                for (var item in data) {
                  listInstituciones.add(item);
                }
                if (!context.mounted) return;
                showSearch(
                  context: context,
                  delegate: SearchInstitucion(
                    listInstituciones,
                    AppLocalizations.of(context)!.searchinst,
                  ),
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
                    image: AssetImage('assets/img/peakpx.jpg'),
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
                    colors: [Colors.white, Colors.white60, Colors.transparent],
                    stops: [0, 0.7, 1],
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/img/smc.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .dashboardMessage,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.provinceVisit,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Center(
                            child: FutureBuilder<List<Provincia>>(
                              future: listProvincias,
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  return CarouselSlider.builder(
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
                                      enableInfiniteScroll: true,
                                    ),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) {
                                      return Material(
                                        elevation: 8,
                                        borderRadius: BorderRadius.circular(15),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
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
                                                  page: ProvinciaPage(
                                                    snapshot
                                                        .data![itemIndex].id,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Card(
                                              elevation: 0,
                                              color: Colors.blueAccent,
                                              clipBehavior: Clip.hardEdge,
                                              child: Wrap(
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        constraints:
                                                            BoxConstraints
                                                                .loose(
                                                          const Size.fromHeight(
                                                              225),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                '$site${snapshot.data![itemIndex].imagen}'),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        transform: Matrix4
                                                            .translationValues(
                                                                0.1,
                                                                -10.0,
                                                                0.1),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .indigoAccent,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.indigo,
                                                              width: 1.0),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(10),
                                                          ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              blurRadius: 15,
                                                              color:
                                                                  Colors.black,
                                                              offset:
                                                                  Offset(1, 3),
                                                            )
                                                          ],
                                                        ),
                                                        child: Text(
                                                          snapshot
                                                              .data![itemIndex]
                                                              .nombre,
                                                          style:
                                                              Theme.of(context)
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
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator
                                    .adaptive();
                              },
                            ),
                          ),
                        ),
                        const ArrowsPage(),
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
          tooltip: AppLocalizations.of(context)!.info,
          label: Text(
            AppLocalizations.of(context)!.info,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
          icon: const Icon(
            Icons.info,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(top: 10.0),
                  backgroundColor: Colors.indigo,
                  title: Text(
                    AppLocalizations.of(context)!.info,
                  ),
                  content: SizedBox(
                    width: 300.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 25,
                            left: 25,
                            bottom: 15,
                          ),
                          child: Column(
                            children: [
                              Text(AppLocalizations.of(context)!.infoMessage),
                              const SizedBox(
                                height: 16,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text.rich(
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.version,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: '0.0.5 ALPHA',
                                        style: GoogleFonts.aBeeZee(
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
          notchMargin: 6,
          height: 45,
          child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.sizeOf(context).height / 20),
            child: Text(
              'Copyright © SMC 2023',
              style: GoogleFonts.abel(),
            ),
          ),
        ),
      ),
    );
  }
}
