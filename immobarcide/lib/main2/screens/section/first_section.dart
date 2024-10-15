import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobarcide/main2/widgets/text_reveal.dart';

class FirstSection extends StatefulWidget {
  const FirstSection({super.key});

  @override
  State<FirstSection> createState() => _FirstSectionState();
}

class _FirstSectionState extends State<FirstSection>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> textRevealAnimation;
  late Animation<double> textOpacityAnimation;
  late Animation<double> descriptionAnimation;
  late Animation<double> smallImageReveal;
  late Animation<double> smallImageOpacity;
  late Animation<double> navBarOpacity;
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
    descriptionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.3, 0.5, curve: Curves.easeOut),
      ),
    );
    smallImageReveal = Tween<double>(begin: 180.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 0.7, curve: Curves.easeOut),
      ),
    );
    smallImageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.6, 0.8, curve: Curves.easeOut),
      ),
    );
    navBarOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.8, 1.0, curve: Curves.easeOut),
      ),
    );
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () {
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 100),
      height: 920,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeTransition(
                        opacity: textOpacityAnimation,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Logo",
                            style: GoogleFonts.montserrat(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextReveal(
                                maxHeight: 90,
                                textOpacityAnimation: textOpacityAnimation,
                                textRevealAnimation: textRevealAnimation,
                                controller: controller,
                                child: Text(
                                  "Healthy & Tasty",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 65,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              TextReveal(
                                maxHeight: 90,
                                textOpacityAnimation: textOpacityAnimation,
                                textRevealAnimation: textRevealAnimation,
                                controller: controller,
                                child: Text(
                                  "Food",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 65,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(height: 30),
                              FadeTransition(
                                opacity: descriptionAnimation,
                                child: Text(
                                  "Lorem Ipsum est un texte d'espace réservé couramment utilisé dans les industries graphique, imprimée et éditoriale pour prévisualiser les mises en page et les maquettes visuelles.",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(height: 50),
                              FadeTransition(
                                opacity: descriptionAnimation,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 15,
                                        color: Colors.black12,
                                      )
                                    ],
                                  ),
                                  child: SizeTransition(
                                    sizeFactor: descriptionAnimation,
                                    axis: Axis.horizontal,
                                    axisAlignment: -1.0,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              contentPadding:
                                                  EdgeInsets.all(12),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 49,
                                          width: 49,
                                          color: Colors.red,
                                          child: Icon(Icons.search),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 50),
                              Flexible(
                                  child: Row(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    width: 180,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(1),
                                          child: Image.network(
                                            "https://picsum.photos/250?image=9",
                                            fit: BoxFit.cover,
                                            width: 180,
                                          ),
                                        ),
                                        Container(
                                          height: 120,
                                          width: smallImageReveal.value,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Flexible(
                                    child: FadeTransition(
                                      opacity: smallImageOpacity,
                                      child: Text(
                                        "Lorem Ipsum est un texte d'espace réservé couramment utilisé dans les industries graphique, imprimée et éditoriale pour prévisualiser les mises en page et les maquettes visuelles.",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 16,
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 150),
                Expanded(child: FirstPageImage()),
                SizedBox(
                  width: 100,
                  height: 500,
                  child: FadeTransition(
                    opacity: navBarOpacity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 80,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.menu),
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: ['Home', 'About', 'Offers', 'Accounts']
                                .map((title) {
                              return RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  title,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class FirstPageImage extends StatefulWidget {
  const FirstPageImage({super.key});

  @override
  State<FirstPageImage> createState() => _FirstPageImageState();
}

class _FirstPageImageState extends State<FirstPageImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 775),
    );
    _animation = Tween<double>(begin: 920, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://picsum.photos/250?image=9",
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          Future.delayed(Duration(milliseconds: 375), () {
            if (_controller.isDismissed) {
              _controller.forward();
            }
          });
          return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    height: 920,
                    width: double.infinity,
                    child: child,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: _animation.value,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  )
                ],
              );
            },
            child: child,
          );
        }
        return SizedBox();
      },
    );
  }
}
