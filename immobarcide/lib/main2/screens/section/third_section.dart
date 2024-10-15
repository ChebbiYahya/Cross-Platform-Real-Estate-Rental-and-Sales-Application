import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobarcide/main2/widgets/text_reveal.dart';

import '../../models/infos.dart';
import '../../models/scroll_offset.dart';
import '../../widgets/info_card.dart';

class ThirdSection extends StatefulWidget {
  const ThirdSection({super.key});

  @override
  State<ThirdSection> createState() => _ThirdSectionState();
}

class _ThirdSectionState extends State<ThirdSection>
    with TickerProviderStateMixin {
  late AnimationController controller;
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
        reverseDuration: Duration(milliseconds: 375));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510,
      color: Colors.red.withOpacity(0.1),
      child: Column(
        children: [
          SizedBox(height: 50),
          BlocBuilder<DisplayOffset, ScrollOffset>(
              buildWhen: (previous, current) {
            if ((current.scrollOffsetValue >= 1900 &&
                    current.scrollOffsetValue <= 2300) ||
                controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          }, builder: (context, state) {
            if (state.scrollOffsetValue > 2100) {
              controller.forward();
            } else {
              controller.reverse();
            }
            return TextReveal(
              controller: controller,
              maxHeight: 50,
              child: Text(
                "How It Works",
                style: GoogleFonts.quicksand(
                  fontSize: 45,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          }),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: infos.map((info) => InfoCard(info: info)).toList(),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
