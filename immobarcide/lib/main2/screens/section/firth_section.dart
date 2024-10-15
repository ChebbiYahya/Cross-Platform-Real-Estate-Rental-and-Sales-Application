import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobarcide/main2/models/chefs.dart';
import 'package:immobarcide/main2/widgets/text_reveal.dart';

import '../../models/scroll_offset.dart';
import '../../widgets/chef_card.dart';

class FirthSection extends StatefulWidget {
  const FirthSection({super.key});

  @override
  State<FirthSection> createState() => _FirthSectionState();
}

class _FirthSectionState extends State<FirthSection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> textRevealAnimation;
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1700),
        reverseDuration: Duration(milliseconds: 375));
    textRevealAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DisplayOffset, ScrollOffset>(
            buildWhen: (previous, current) {
          if (current.scrollOffsetValue >= 3000) {
            return true;
          } else {
            return false;
          }
        }, builder: (context, state) {
          if (state.scrollOffsetValue > 3100) {
            controller.forward();
          } else {
            controller.reverse();
          }
          return TextReveal(
            maxHeight: 55,
            controller: controller,
            child: Text(
              "Most Experts Chefs",
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: chefs
              .map(
                (chef) => ChefCard(
                  chef: chef,
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
