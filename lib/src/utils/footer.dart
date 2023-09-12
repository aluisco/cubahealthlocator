import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterPage extends StatelessWidget {
  const FooterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
      child: Text(
        'Copyright © SMC 2023',
        style: GoogleFonts.abel(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
