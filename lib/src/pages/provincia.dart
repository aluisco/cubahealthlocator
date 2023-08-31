import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smcsalud/src/api/municipio_provider.dart';
import 'package:smcsalud/src/api/provincia_provider.dart';
import 'package:smcsalud/src/constants.dart';
import 'package:smcsalud/src/models/municipio.dart';
import 'package:smcsalud/src/models/provincia.dart';
import 'package:smcsalud/src/pages/municipio.dart';

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
              centerTitle: true,
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
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage('assets/img/pbackground.jpg'),
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
                                        '$site${provincia.imagen}'),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    provincia.descripcion,
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
                              itemCount: municipios.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return MunicipioPage(
                                            municipios[itemIndex].id,
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
                                            '$site${municipios[itemIndex].imagen}',
                                            fit: BoxFit.cover,
                                            height: 205,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          municipios[itemIndex].nombre,
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
        return const CircularProgressIndicator();
      },
    );
  }
}
