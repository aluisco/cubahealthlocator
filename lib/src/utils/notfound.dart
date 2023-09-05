import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.warning,
              size: 40,
            ),
            SizedBox(
              height: 20,
            ),
            Text('No se encontraron resultados!'),
          ],
        ),
      ),
    );
  }
}
