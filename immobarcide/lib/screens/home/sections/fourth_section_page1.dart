import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../main2/models/scroll_offset.dart';
import '../../../text_reveal.dart';

class FourthSection extends StatefulWidget {
  const FourthSection({super.key});

  @override
  State<FourthSection> createState() => _FourthSectionState();
}

class _FourthSectionState extends State<FourthSection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> textRevealAnimation;
  late Animation<double> textOpacityAnimation;
  late Animation<double> imageRevealAnimation;
  @override
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
    textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );
    imageRevealAnimation = Tween<double>(begin: 500.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Container(
      padding: _size.width > 1300
          ? EdgeInsets.symmetric(horizontal: 150, vertical: 20)
          : EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: BlocBuilder<DisplayOffset, ScrollOffset>(
          buildWhen: (previous, current) {
        if ((current.scrollOffsetValue >= 2000 &&
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
        return Column(
          children: [
            _size.width > 600
                ? WebSolution(
                    controller: controller,
                    textOpacityAnimation: textOpacityAnimation,
                    textRevealAnimation: textRevealAnimation,
                    imageRevealAnimation: imageRevealAnimation)
                : MobileSolution(
                    controller: controller,
                    imageRevealAnimation: imageRevealAnimation,
                    textOpacityAnimation: textOpacityAnimation,
                    textRevealAnimation: textRevealAnimation),
          ],
        );
      }),
    );
  }
}

class MobileSolution extends StatelessWidget {
  const MobileSolution({
    super.key,
    required this.controller,
    required this.imageRevealAnimation,
    required this.textOpacityAnimation,
    required this.textRevealAnimation,
  });

  final AnimationController controller;
  final Animation<double> imageRevealAnimation;
  final Animation<double> textOpacityAnimation;
  final Animation<double> textRevealAnimation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextReveal(
          maxHeight: 100,
          controller: controller,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/icons/arrowDownRight.svg",
                width: 40,
                color: kHoverColor,
              ),
              Text("NOTRE VALEURS",
                  style: Theme.of(context).textTheme.headline2),
            ],
          ),
        ),
        Stack(
          children: [
            Image.asset("assets/images/ourValue.png"),
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
        TextReveal(
          maxHeight: 200,
          textOpacityAnimation: textOpacityAnimation,
          textRevealAnimation: textRevealAnimation,
          controller: controller,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: Theme.of(context).textTheme.headline1,
                children: [
                  TextSpan(text: 'Débloquer '),
                  TextSpan(text: "\nLes Services D'évaluation \n"),
                  TextSpan(
                    text: 'Services.',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: kHoverColor),
                  ),
                ]),
          ),
        ),
        SizedBox(height: 10),
        TextReveal(
          maxHeight: 90,
          textOpacityAnimation: textOpacityAnimation,
          textRevealAnimation: textRevealAnimation,
          controller: controller,
          child: Text(
              "  Nos experts peuvent fournir des informations précieuses\n et vous aider à identifier les biens.",
              style: Theme.of(context).textTheme.headline5),
        ),
      ],
    );
  }
}

class WebSolution extends StatelessWidget {
  const WebSolution({
    super.key,
    required this.controller,
    required this.textOpacityAnimation,
    required this.textRevealAnimation,
    required this.imageRevealAnimation,
  });

  final AnimationController controller;
  final Animation<double> textOpacityAnimation;
  final Animation<double> textRevealAnimation;
  final Animation<double> imageRevealAnimation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Image.asset("assets/images/ourValue.png"),
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
        SizedBox(width: 30),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextReveal(
                maxHeight: 100,
                controller: controller,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/arrowDownRight.svg",
                      width: 40,
                      color: kHoverColor,
                    ),
                    Text("NOTRE VALEURS",
                        style: Theme.of(context).textTheme.headline2),
                  ],
                ),
              ),
              TextReveal(
                maxHeight: 200,
                textOpacityAnimation: textOpacityAnimation,
                textRevealAnimation: textRevealAnimation,
                controller: controller,
                child: RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.headline1,
                      children: [
                        TextSpan(text: 'Débloquer'),
                        TextSpan(text: "\nLes Services D'évaluation \n"),
                        TextSpan(
                          text: ' Services.',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: kHoverColor),
                        ),
                      ]),
                ),
              ),
              SizedBox(height: 10),
              TextReveal(
                maxHeight: 90,
                textOpacityAnimation: textOpacityAnimation,
                textRevealAnimation: textRevealAnimation,
                controller: controller,
                child: Text(
                    "  Nos experts peuvent fournir des informations précieuses\n et vous aider à identifier les biens.",
                    style: Theme.of(context).textTheme.headline5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
