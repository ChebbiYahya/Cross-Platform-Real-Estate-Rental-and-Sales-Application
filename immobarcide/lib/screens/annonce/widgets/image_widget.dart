import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:immobarcide/models/annonce_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../constants.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({
    required this.annonce,
    super.key,
  });
  final Annonce annonce;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final controller = CarouselController();
  int activeIndex = 0;
  final listImage = [
    "assets/images/ad_image/adImage3.jpg",
    "assets/images/ad_image/adImage1.jpg",
    "assets/images/ad_image/adImage2.jpg",
    "assets/images/ad_image/adImage3.jpg",
    "assets/images/ad_image/adImage4.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          Stack(
            children: [
              Hero(tag: widget.annonce.id!, child: buildImageSlider()),
              Positioned(left: -20, top: 200, child: buildButtonBack()),
              Positioned(right: -20, top: 200, child: buildButtonForward()),
            ],
          ),
          SizedBox(height: 20),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildImageSlider() => CarouselSlider.builder(
        carouselController: controller,
        itemCount: widget.annonce.images!.length,
        itemBuilder: (context, index, realIndex) {
          final oneImage = widget.annonce.images![index];
          return buildImage(oneImage, index);
        },
        options: CarouselOptions(
          height: 400,
          initialPage: 0,
          autoPlay: true,
          enlargeCenterPage: true,
          //enableInfiniteScroll: false,
          //viewportFraction: 1,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          autoPlayAnimationDuration: Duration(seconds: 2),
          onPageChanged: (index, reason) => setState(() => activeIndex = index),
        ),
      );

  Widget buildImage(String oneImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Image.network(
          oneImage,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.annonce.images!.length,
        onDotClicked: animatedToSlide,
        effect: WormEffect(
          dotWidth: 20,
          dotHeight: 20,
          activeDotColor: Colors.red,
          dotColor: Colors.black12,
        ),
      );
  Widget buildButtonBack({bool stretch = false}) => ElevatedButton(
        onPressed: previous,
        child: Icon(Icons.arrow_back, size: 32),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent.withOpacity(0.2),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: CircleBorder(),
        ),
      );
  Widget buildButtonForward({bool stretch = false}) => ElevatedButton(
        onPressed: next,
        child: Icon(Icons.arrow_forward, size: 32),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent.withOpacity(0.2),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: CircleBorder(),
        ),
      );

  void next() {
    controller.nextPage(duration: Duration(milliseconds: 500));
  }

  void previous() {
    controller.previousPage(duration: Duration(milliseconds: 500));
  }

  void animatedToSlide(int index) => controller.animateToPage(index);
}
