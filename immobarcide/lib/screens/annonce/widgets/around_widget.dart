import 'package:flutter/material.dart';
import 'package:immobarcide/models/annonce_model.dart';
import '../../../constants.dart';
import 'icon_around_widget.dart';

class AroundWidget extends StatelessWidget {
  const AroundWidget({super.key, required this.annonce});
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
            "Localisation",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
            textAlign: TextAlign.start,
          ),
          Divider(thickness: 2),
          //if (annonce.aroundCityDistance != null)
          IconAroundWidget(
            iconString: "assets/images/ad_icons/geolocalisation.svg",
            title: "CENTRE VILLE",
            subtile: annonce.ville,
            distance: annonce.aroundCityDistance,
          ),
          if (annonce.aroundAirportDistance != "") Divider(),
          if (annonce.aroundAirportDistance != "")
            IconAroundWidget(
              iconString: "assets/images/ad_icons/airport.svg",
              title: "AIRPORTS",
              subtile: annonce.aroundAirportName,
              distance: annonce.aroundAirportDistance,
            ),
          if (annonce.aroundTrainDistance != "") Divider(),
          if (annonce.aroundTrainDistance != "")
            IconAroundWidget(
              iconString: "assets/images/ad_icons/train.svg",
              title: "TRAIN",
              subtile: annonce.aroundTrainName,
              distance: annonce.aroundTrainDistance,
            ),
          if (annonce.aroundMetroDistance != "") Divider(),
          if (annonce.aroundMetroDistance != "")
            IconAroundWidget(
              iconString: "assets/images/ad_icons/metro.svg",
              title: "STATIONS MÉTRO",
              subtile: annonce.aroundMetroName,
              distance: annonce.aroundMetroDistance,
            ),
          if (annonce.aroundBusDistance != "") Divider(),
          if (annonce.aroundBusDistance != "")
            IconAroundWidget(
              iconString: "assets/images/ad_icons/bus.svg",
              title: "STATIONS DE BUS",
              subtile: annonce.aroundBusName,
              distance: annonce.aroundBusDistance,
            ),
          if (annonce.aroundShopDistance != "") Divider(),
          if (annonce.aroundShopDistance != "")
            IconAroundWidget(
              iconString: "assets/images/ad_icons/shop.svg",
              title: "MAGASIN",
              subtile: annonce.aroundShopName,
              distance: annonce.aroundShopDistance,
            ),
        ],
      ),
    );
  }
}
