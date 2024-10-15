import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobarcide/main2/widgets/text_reveal.dart';

import '../../models/scroll_offset.dart';

class FourthSection extends StatefulWidget {
  const FourthSection({super.key});

  @override
  State<FourthSection> createState() => _FourthSectionState();
}

class _FourthSectionState extends State<FourthSection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> imageRevealAnimation;
  late Animation<double> textRevealAnimation;
  late Animation<double> subTextOpacityAnimation;
  late Animation<double> subImageRevealAnimation;
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1700),
        reverseDuration: Duration(milliseconds: 375));
    imageRevealAnimation = Tween<double>(begin: 500.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    textRevealAnimation = Tween<double>(begin: 70.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 0.8, curve: Curves.easeOut),
      ),
    );
    subTextOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.3, 0.6, curve: Curves.easeOut),
      ),
    );
    subImageRevealAnimation = Tween<double>(begin: 0.0, end: 90.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayOffset, ScrollOffset>(
        buildWhen: (previous, current) {
      if (current.scrollOffsetValue >= 2800) {
        return true;
      } else {
        return false;
      }
    }, builder: (context, state) {
      if (state.scrollOffsetValue > 2900) {
        controller.forward();
      } else {
        controller.reverse();
      }
      return SizedBox(
        height: 500,
        child: Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            Flexible(
              child: Stack(
                children: [
                  Container(
                    width: 400,
                    padding: EdgeInsets.all(1),
                    child: Image.network(
                      "https://picsum.photos/250?image=9",
                      fit: BoxFit.cover,
                    ),
                  ),
                  AnimatedBuilder(
                      animation: imageRevealAnimation,
                      builder: (context, child) {
                        return Container(
                          height: imageRevealAnimation.value,
                          width: double.infinity,
                          color: Colors.white,
                          alignment: Alignment(0.0, -1.0),
                        );
                      }),
                ],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            AnimatedBuilder(
                animation: textRevealAnimation,
                builder: (context, child) {
                  return Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextReveal(
                          maxHeight: 55,
                          controller: controller,
                          child: Text(
                            "Order Your",
                            style: GoogleFonts.quicksand(
                                fontSize: 45, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextReveal(
                          maxHeight: 55,
                          controller: controller,
                          child: Text(
                            "Favourite Food",
                            style: GoogleFonts.quicksand(
                                fontSize: 30, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: 30),
                        AnimatedBuilder(
                            animation: subTextOpacityAnimation,
                            builder: (context, child) {
                              return FadeTransition(
                                opacity: subTextOpacityAnimation,
                                child: Text(
                                  "Lorem Ipsum est un texte d'espace réservé couramment utilisé dans les industries graphique",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }),
                        SizedBox(height: 20),
                        AnimatedBuilder(
                            animation: subTextOpacityAnimation,
                            builder: (context, child) {
                              return FadeTransition(
                                opacity: subTextOpacityAnimation,
                                child: Text(
                                  "Lorem Ipsum est un texte d'espace réservé couramment utilisé dans les industries graphique",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }),
                        SizedBox(height: 50),
                        Container(
                          height: 90,
                          alignment: Alignment(0, -1),
                          child: AnimatedBuilder(
                              animation: subImageRevealAnimation,
                              builder: (context, child) {
                                return SizedBox(
                                  height: subImageRevealAnimation.value,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          "https://picsum.photos/250?image=9",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Image.network(
                                          "https://picsum.photos/250?image=9",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                }),
            SizedBox(width: MediaQuery.of(context).size.width * 0.1)
          ],
        ),
      );
    });
  }
}
