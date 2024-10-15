import 'package:flutter/material.dart';
import 'package:immobarcide/models/annonce_model.dart';
import '../../../constants.dart';
import 'iconToKnowWidget.dart';

class ToKnow extends StatelessWidget {
  const ToKnow({required this.annonce, super.key});
  final Annonce annonce;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: kLightBlueColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Good to know",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
            textAlign: TextAlign.start,
          ),
          Divider(thickness: 2),
          IconToKnowWidget(
            iconString: "assets/images/ad_icons/clock.svg",
            title: "CHECK-IN",
            subtitle: "From ${annonce.checkInFrom}-${annonce.checkInTo}",
          ),
          Divider(),
          IconToKnowWidget(
            iconString: "assets/images/ad_icons/clock.svg",
            title: "CHECK-OUT",
            subtitle: "From ${annonce.checkOutFrom}-${annonce.checkOutTo}",
          ),
          /* Divider(),
          IconToKnowWidget(
            iconString: "assets/images/ad_icons/no_pet.svg",
            title: "PETS",
            subtitle: "Pets are not allowed.",
          ),*/
        ],
      ),
    );
  }
}
