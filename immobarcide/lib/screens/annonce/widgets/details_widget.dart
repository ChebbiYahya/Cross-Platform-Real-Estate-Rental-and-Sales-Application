import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/annonce_model.dart';
import 'icon_details_widget.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    required this.annonce,
    super.key,
  });
  final Annonce annonce;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: kLightBlueColor, borderRadius: BorderRadius.circular(10)),
      // height: 200,
      //color: Colors.greenAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Details",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
            textAlign: TextAlign.start,
          ),
          Divider(thickness: 2),
          IconDetailsWidget(
            iconString: "assets/images/ad_icons/flat.svg",
            title: annonce.categorie,
          ),
          SizedBox(height: 20),
          IconDetailsWidget(
            iconString: "assets/images/ad_icons/size.svg",
            title: annonce.totalArea,
          ),
          SizedBox(height: 20),
          IconDetailsWidget(
            iconString: "assets/images/ad_icons/geolocalisation.svg",
            title: annonce.ville,
            subtitle: annonce.cite,
          ),
        ],
      ),
    );
  }
}
