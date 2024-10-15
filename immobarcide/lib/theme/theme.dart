import 'package:flutter/material.dart';

import 'widget-theme/elevated_button_theme.dart';
import 'widget-theme/outlined_button_theme.dart';
import 'widget-theme/text_field_theme.dart';
import 'widget-theme/text_theme.dart';

class TAppTheme {
  TAppTheme._();
  //desktop
  static ThemeData desktopTheme = ThemeData(
    elevatedButtonTheme: TElavatedButtonTheme.largeElevatedButtonTheme,
    outlinedButtonTheme: TOutlineButtonTheme.largeOutlineButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.inputDecorationTheme,
    textTheme: TTextTheme.desktopTextTheme,
  );
  //mobile
  static ThemeData mobileTheme = ThemeData(
    elevatedButtonTheme: TElavatedButtonTheme.smallElevatedButtonTheme,
    outlinedButtonTheme: TOutlineButtonTheme.smallOutlineButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.inputDecorationTheme,
    textTheme: TTextTheme.mobileTextTheme,
  );
}
