import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomScrollBeharvior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
