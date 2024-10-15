import 'package:flutter/material.dart';

import '../../../constants.dart';

class TElavatedButtonTheme {
  TElavatedButtonTheme._();
  static final largeElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: kWhiteColor,
      backgroundColor: kBlueColor,
      side: BorderSide(style: BorderStyle.none),
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
    ),
  );
  static final smallElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: kWhiteColor,
      backgroundColor: kBlueColor,
      side: BorderSide(style: BorderStyle.none),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    ),
  );
}
