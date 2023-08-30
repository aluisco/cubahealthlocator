import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smcsalud/src/api/provincia_provider.dart';
import 'package:smcsalud/src/constants.dart';
import 'package:smcsalud/src/models/provincia.dart';
import 'package:smcsalud/src/pages/provincia.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<List<Provincia>> listProvincias;

  @override
  void initState() {
    listProvincias = getProvincias();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Inicio',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
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
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                'assets/img/smc.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Text(
                              'Visite todos nuestros sitios ubicados en todo nuestro territorio nacional, puede realizar un recorrido por todas nuestras provincias y conocer cada detalle y ubicación que corresponde con servicios ubicados especificamente para ayudarlo a tener una mejor estancia en nuestro país. ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Center(
                        child: FutureBuilder<List<Provincia>>(
                          future: listProvincias,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CarouselSlider.builder(
                                options: CarouselOptions(
                                  aspectRatio: 1.5,
                                  viewportFraction: 0.8,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  autoPlay: false,
                                  enlargeFactor: 0.3,
                                  scrollDirection: Axis.horizontal,
                                ),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context,
                                    int itemIndex, int pageViewIndex) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return ProvinciaPage(
                                              snapshot.data![itemIndex].id,
                                            );
                                          },
                                        ),
                                      );
                                    },
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
                                              '$site${snapshot.data![itemIndex].imagen}',
                                              fit: BoxFit.cover,
                                              height: 205,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            snapshot.data![itemIndex].nombre,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.indigo,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Copyright © SMC 2023',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                contentPadding: const EdgeInsets.only(top: 10.0),
                backgroundColor: Colors.indigo,
                title: const Text(
                  'Información',
                ),
                content: const SizedBox(
                  width: 300.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Text(
                                'Aplicación diseñada para proporcionar información sobre los diferentes lugares que Ofrece la Comercializadora a Nivel Nacional.'),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                                'Si desea ponerse en contacto con el desarrollador por favor escriba al correo admin@smcsalud.cu'),
                            SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text.rich(
                                TextSpan(
                                  text: 'Versión: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: '0.1 Beta',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.redAccent,
                                      ),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('OK'),
                    ),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Información de la aplicación.',
        child: const Icon(
          Icons.info,
          color: Colors.white,
        ),
      ),
    );
  }
}
