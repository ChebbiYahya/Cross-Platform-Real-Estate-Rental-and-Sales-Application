import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:immobarcide/screens/home/widget/info_card_mobile.dart';
import '../../../constants.dart';
import '../../../main2/models/scroll_offset.dart';
import '../../../models/infos.dart';
import '../../../text_reveal.dart';
import '../widget/info_card.dart';

class FirthSection extends StatefulWidget {
  const FirthSection({super.key});

  @override
  State<FirthSection> createState() => _FirthSectionState();
}

class _FirthSectionState extends State<FirthSection>
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
    var _size = MediaQuery.of(context).size;

    return Container(
      //height: 510,
      //color: Colors.red.withOpacity(0.1),
      child: Column(
        children: [
          SizedBox(height: 50),
          BlocBuilder<DisplayOffset, ScrollOffset>(
              buildWhen: (previous, current) {
            if ((current.scrollOffsetValue >= 2300 &&
                    current.scrollOffsetValue <= 2700) ||
                controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          }, builder: (context, state) {
            if (state.scrollOffsetValue > 2500) {
              controller.forward();
            } else {
              controller.reverse();
            }
            return TextReveal(
              maxHeight: 50,
              controller: controller,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/arrowDownRight.svg",
                    width: 40,
                    color: kHoverColor,
                  ),
                  Text("Notre Equipe",
                      style: Theme.of(context).textTheme.headline2),
                ],
              ),
            );
          }),
          // SizedBox(height: 20),
          if (_size.width > 900)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: infos.map((info) => InfoCard(info: info)).toList(),
            ),
          if (_size.width < 900)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  infos1.map((info) => InfoCardMobile(info: info)).toList(),
            ),
          if (_size.width < 900)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  infos2.map((info) => InfoCardMobile(info: info)).toList(),
            ),
        ],
      ),
    );
  }
}
