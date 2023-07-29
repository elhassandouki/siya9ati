import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: const Color(0xfffbb448),

    ///app bar
    primaryColorDark: const Color(0xfffbb448),

    primaryColorLight: const Color(0xfffbb448),
    scaffoldBackgroundColor:
        Color.fromARGB(255, 242, 242, 245), //const Color(0xFFdcdeeb),

    ///scaffold
    secondaryHeaderColor: const Color(0xfffbb448),

    /// bottons
    cardColor: Colors.transparent,

    textTheme: TextTheme(
      headlineLarge: GoogleFonts.cairo(
        color: Color(0xfffbb448),
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),

      //text of botons and appbar
      headlineMedium: GoogleFonts.cairo(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),

      /// soal jawab
      headlineSmall: GoogleFonts.cairo(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),

      /// soal jawab
      bodyLarge: GoogleFonts.cairo(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),

      /// body style  mokhalafat style
      bodyMedium: GoogleFonts.cairo(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
    ),
  );
}



///color:  Theme.of(context).primaryColorDark,
///style: Theme.of(context).textTheme.headlineMedium,