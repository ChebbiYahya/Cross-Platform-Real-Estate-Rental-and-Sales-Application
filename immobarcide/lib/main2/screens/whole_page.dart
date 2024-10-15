import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:immobarcide/main2/models/scroll_offset.dart';
import 'package:immobarcide/main2/screens/section/first_section.dart';
import 'package:immobarcide/main2/screens/section/second_section.dart';
import 'package:immobarcide/main2/screens/section/third_section.dart';

import 'section/firth_section.dart';
import 'section/fourth_section.dart';
import 'section/sixth_section.dart';

class WholePage extends StatefulWidget {
  const WholePage({super.key});

  @override
  State<WholePage> createState() => _WholePageState();
}

class _WholePageState extends State<WholePage> {
  late ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();
    super.initState();
    controller.addListener(() {
      context.read<DisplayOffset>().changeDisplayOffset(
          (MediaQuery.of(context).size.height + controller.position.pixels)
              .toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          FirstSection(),
          SizedBox(height: 100),
          SecondSection(),
          SizedBox(height: 100),
          ThirdSection(),
          SizedBox(height: 100),
          FourthSection(),
          SizedBox(height: 100),
          FirthSection(),
          SizedBox(height: 100),
          SixthSection(),
        ],
      ),
    );
  }
}
