import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants.dart';

class TTextTheme {
  //Desktop
  static TextTheme desktopTextTheme = TextTheme(
    headline1: GoogleFonts.quicksand(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline2: GoogleFonts.quicksand(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline3: GoogleFonts.quicksand(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline4: GoogleFonts.quicksand(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline5: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline6: GoogleFonts.quicksand(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: kDarkBlueColor,
    ),
    bodyText1: GoogleFonts.quicksand(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: kDarkBlueColor.withOpacity(0.7),
    ),
    bodyText2: GoogleFonts.quicksand(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: kDarkBlueColor.withOpacity(0.7),
    ),
  );
  //Mobile

  static TextTheme mobileTextTheme = TextTheme(
    headline1: GoogleFonts.quicksand(
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline2: GoogleFonts.quicksand(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline3: GoogleFonts.quicksand(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline4: GoogleFonts.quicksand(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: kDarkBlueColor,
    ),
    headline5: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: kDarkBlueColor,
    ),
    headline6: GoogleFonts.quicksand(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: kDarkBlueColor,
    ),
    bodyText1: GoogleFonts.quicksand(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: kDarkBlueColor,
    ),
    bodyText2: GoogleFonts.quicksand(
      fontSize: 11,
      fontWeight: FontWeight.normal,
      color: kDarkBlueColor.withOpacity(0.7),
    ),
  );
}
