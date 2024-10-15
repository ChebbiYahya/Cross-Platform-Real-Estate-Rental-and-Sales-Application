import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobarcide/main2/models/items.dart';
import 'package:immobarcide/main2/models/scroll_offset.dart';
import 'package:immobarcide/main2/widgets/text_reveal.dart';

import '../../widgets/item_card.dart';

class SecondSection extends StatefulWidget {
  const SecondSection({super.key});

  @override
  State<SecondSection> createState() => _SecondSectionState();
}

class _SecondSectionState extends State<SecondSection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1700),
        reverseDuration: Duration(milliseconds: 375));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DisplayOffset, ScrollOffset>(
          buildWhen: (previous, current) {
            if ((current.scrollOffsetValue >= 900 &&
                    current.scrollOffsetValue <= 1300) ||
                controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state.scrollOffsetValue > 1100) {
              controller.forward();
            } else {
              controller.reverse();
            }
            return TextReveal(
              maxHeight: 70,
              controller: controller,
              child: Text(
                "Dish of the day",
                style: GoogleFonts.quicksand(
                  fontSize: 55,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
        ),
        SizedBox(height: 100),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
          child: Center(
            child: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 70,
              spacing: 100,
              children: items.map<Widget>((item) {
                return ItemCard(
                  image: item.image,
                  title: item.title,
                  subtitle: item.subtitle,
                  description: item.description,
                  price: item.price,
                  index: items.indexOf(item),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
