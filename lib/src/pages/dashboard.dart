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
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/peakpx.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
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
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        autoPlay: false,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            child: ListView(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
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
        ),
      ),
    );
  }
}
