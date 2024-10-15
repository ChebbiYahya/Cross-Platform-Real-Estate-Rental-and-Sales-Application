import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main2/models/scroll_offset.dart';
import 'sections/first_section_page1.dart';
import 'sections/firth_section_page1.dart';
import 'sections/six_section_page1.dart';
import 'sections/fourth_section_page1.dart';
import 'sections/second_section_page1.dart';
import 'sections/third_section_page1.dart';

class HomeScreen extends StatefulWidget {
  final void Function(int)? onTabChangedWeb;
  final void Function(int)? onTabChangedMobile;
  final void Function(String)? onTabChangedFilterLocation;
  final void Function(String)? onTabChangedFilterCategory;
  final void Function(String)? onTabChangedFilterType;
  final void Function(bool)? onTabChangedHomeFilter;

  const HomeScreen(
      {this.onTabChangedWeb,
      this.onTabChangedMobile,
      this.onTabChangedFilterCategory,
      this.onTabChangedFilterLocation,
      this.onTabChangedFilterType,
      this.onTabChangedHomeFilter,
      super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      controller: controller,
      child: Container(
        child: Column(
          children: [
            FirstSection(
              onTabChangedWeb: widget.onTabChangedWeb!,
              onTabChangedMobile: widget.onTabChangedMobile,
              onTabChangedFilterCategory: widget.onTabChangedFilterCategory,
              onTabChangedFilterType: widget.onTabChangedFilterType,
              onTabChangedFilterLocation: widget.onTabChangedFilterLocation,
              onTabChangedHomeFilter: widget.onTabChangedHomeFilter,
            ),
            SizedBox(height: 30),
            SecondSection(),
            SizedBox(height: 30),
            ThirdSection(),
            SizedBox(height: 30),
            FourthSection(),
            SizedBox(height: 30),
            FirthSection(),
            SizedBox(height: 30),
            if (_size.width > 600) SixSection(),
          ],
        ),
      ),
    );
  }
}
