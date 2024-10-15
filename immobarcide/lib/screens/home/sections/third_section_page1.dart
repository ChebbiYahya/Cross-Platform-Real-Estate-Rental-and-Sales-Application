import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:immobarcide/controllers/annonce_controller.dart';
import '../../../constants.dart';
import '../../../main2/models/scroll_offset.dart';
import '../../../models/annonce_model.dart';
import '../../../text_reveal.dart';
import '../widget/card_widget.dart';

class ThirdSection extends StatefulWidget {
  const ThirdSection({super.key});

  @override
  State<ThirdSection> createState() => _ThirdSectionState();
}

class _ThirdSectionState extends State<ThirdSection>
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
    ScrollController _slidingScollBar = ScrollController();
    final annonceController = Get.put(AnnonceController());

    return Container(
      //height: 500,
      width: double.infinity,
      color: kLightBlueColor,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: BlocBuilder<DisplayOffset, ScrollOffset>(
            buildWhen: (previous, current) {
          if ((current.scrollOffsetValue >= 1400 &&
                  current.scrollOffsetValue <= 2000) ||
              controller.isAnimating) {
            return true;
          } else {
            return false;
          }
        }, builder: (context, state) {
          if (state.scrollOffsetValue > 1400) {
            controller.forward();
          } else {
            controller.reverse();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextReveal(
                maxHeight: 100,
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
                    Flexible(
                      child: Text("NOS MEILLEURES MAISONS",
                          style: Theme.of(context).textTheme.headline2),
                    ),
                  ],
                ),
              ),
              TextReveal(
                maxHeight: 180,
                textOpacityAnimation: textOpacityAnimation,
                textRevealAnimation: textRevealAnimation,
                controller: controller,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline1,
                    children: [
                      TextSpan(text: "Trouvez Votre Maison \n De"),
                      TextSpan(
                        text: ' Rêve ',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: kHoverColor),
                      ),
                      TextSpan(text: 'Ici'),
                    ],
                  ),
                ),
              ),
              TextReveal(
                maxHeight: 150,
                textOpacityAnimation: textOpacityAnimation,
                textRevealAnimation: textRevealAnimation,
                controller: controller,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: kHoverColor,
                        size: 20,
                      ),
                      onPressed: () {
                        _size.width > 500
                            ? _slidingScollBar.animateTo(
                                _slidingScollBar.offset - 420,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn)
                            : _slidingScollBar.animateTo(
                                _slidingScollBar.offset - 290,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        _size.width > 500
                            ? _slidingScollBar.animateTo(
                                _slidingScollBar.offset + 420,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn)
                            : _slidingScollBar.animateTo(
                                _slidingScollBar.offset + 290,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                      },
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        size: 20,
                        color: kHoverColor,
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: _size.width > 950 ? 430 : 460,
                child: FutureBuilder<List<Annonce>>(
                    future: annonceController.getAllOffersInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            controller: _slidingScollBar,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return AnimatedCrossFade(
                                crossFadeState: state.scrollOffsetValue >= 700
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: Duration(milliseconds: 575),
                                reverseDuration: Duration(milliseconds: 375),
                                alignment: Alignment.center,
                                firstCurve: Curves.easeOut,
                                secondCurve: Curves.easeOut,
                                firstChild: Container(
                                  height: 400,
                                  width: 400,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 5),
                                ),
                                secondChild: CardWidget(
                                  annonce: snapshot.data![index],
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return Center(
                              child: Text("Quelque chose n'a pas fonctionné"));
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
