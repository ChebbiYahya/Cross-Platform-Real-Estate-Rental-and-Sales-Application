import 'package:flutter/material.dart';
import 'package:immobarcide/models/annonce_model.dart';

import '../../../constants.dart';

class CaracteristicWidget extends StatelessWidget {
  const CaracteristicWidget({required this.annonce, super.key});
  final Annonce annonce;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: kLightBlueColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Caractéristiques",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Divider(thickness: 2),
            CaracteristicTextWidget(
                title: "Surface utilisable:", subtitle: annonce.useableArea),
            CaracteristicTextWidget(
                title: "Surface totale: ", subtitle: annonce.totalArea),
            if (annonce.nbGarage != 0)
              CaracteristicTextWidget(
                  title: "Nombre de chambres:",
                  subtitle: annonce.nbRooms.toString()),
            if (annonce.nbGarage != 0)
              CaracteristicTextWidget(
                  title: "Nombre de salles de bains:",
                  subtitle: annonce.nbBathrooms.toString()),
            if (annonce.nbGarage != 0)
              CaracteristicTextWidget(
                  title: "Garages: ", subtitle: "${annonce.nbGarage} cars"),
            if (annonce.bacony == true)
              CaracteristicTextWidget(
                  title: "Balcon:", subtitle: annonce.bacony.toString()),
            if (annonce.terace == true)
              CaracteristicTextWidget(
                  title: "Terrasse: ", subtitle: annonce.terace.toString()),
            if (annonce.jardin == true)
              CaracteristicTextWidget(
                  title: "Jardin: ", subtitle: annonce.jardin.toString()),
            CaracteristicTextWidget(
                title: "Type: ", subtitle: annonce.buyOrRent.toString()),
            if (annonce.price != "")
              CaracteristicTextWidget(
                  title: "Price: ", subtitle: annonce.price.toString()),
          ],
        ));
  }
}

class CaracteristicTextWidget extends StatelessWidget {
  const CaracteristicTextWidget({
    this.title,
    this.subtitle,
    super.key,
  });
  final String? title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w800, fontSize: 16),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 5),
          Text(
            subtitle!,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
