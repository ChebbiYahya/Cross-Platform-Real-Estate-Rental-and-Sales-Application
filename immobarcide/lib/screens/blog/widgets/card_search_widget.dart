import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import '../../../models/annonce_model.dart';
import '../../annonce/annonce_screen.dart';

class CardSearchWidget extends StatelessWidget {
  const CardSearchWidget({super.key, required this.annonce});
  final Annonce annonce;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AnnonceScreen(annonce: annonce)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: _size.width > 2000 ? 500 : 400,
        decoration: BoxDecoration(
          //color: Colors.grey[300],
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: Offset(4.0, 4.0),
                blurRadius: 15,
                spreadRadius: 1),
            BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15,
                spreadRadius: 1),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Image border
                child: Hero(
                  tag: annonce.id!,
                  child: Stack(
                    children: [
                      Image.network(
                        annonce.images![0],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: annonce.buyOrRent == "Vente"
                                ? Text("Vente",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: kHoverColor,
                                            fontWeight: FontWeight.w700))
                                : Text("Location",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: kHoverColor,
                                            fontWeight: FontWeight.w700))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _size.width > 1050
                      ? WebCaracteristics(context)
                      : MobileCaracteristics(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container MobileCaracteristics(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            annonce.title.toString(),
            style: Theme.of(context).textTheme.headline4,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(height: 5),
          Text(
            "${annonce.ville.toString()}, ${annonce.cite.toString()}",
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (annonce.nbRooms != "")
                    CaractresticImage(
                        imageString: "assets/images/ad_icons/bed.svg",
                        title: "${annonce.nbRooms} Chambres"),
                  if (annonce.nbBathrooms != "")
                    CaractresticImage(
                        imageString: "assets/images/ad_icons/bath.svg",
                        title: "${annonce.nbBathrooms} Toilettes"),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (annonce.nbGarage != "")
                    CaractresticImage(
                        imageString: "assets/images/ad_icons/car.svg",
                        title: "${annonce.nbGarage} Garages"),
                  if (annonce.totalArea != "")
                    CaractresticImage(
                        imageString: "assets/images/ad_icons/angularRuler.svg",
                        title: "${annonce.totalArea}"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container WebCaracteristics(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            annonce.title.toString(),
            style: Theme.of(context).textTheme.headline4,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(height: 5),
          Text(
            "${annonce.ville.toString()}, ${annonce.cite.toString()}",
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (annonce.nbRooms != "")
                CaractresticImage(
                    imageString: "assets/images/ad_icons/bed.svg",
                    title: "${annonce.nbRooms} Chambres"),
              if (annonce.nbBathrooms != "")
                CaractresticImage(
                    imageString: "assets/images/ad_icons/bath.svg",
                    title: "${annonce.nbBathrooms} Toilettes"),
              if (annonce.nbGarage != "")
                CaractresticImage(
                    imageString: "assets/images/ad_icons/car.svg",
                    title: "${annonce.nbGarage} Garages"),
              if (annonce.totalArea != "")
                CaractresticImage(
                    imageString: "assets/images/ad_icons/angularRuler.svg",
                    title: "${annonce.totalArea}"),
            ],
          ),
        ],
      ),
    );
  }
}

class CaractresticImage extends StatelessWidget {
  const CaractresticImage({
    this.imageString,
    this.title,
    super.key,
  });
  final String? imageString, title;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_size.width > 1050)
            Column(
              children: [
                SvgPicture.asset(
                  imageString!,
                  width: 30,
                ),
                SizedBox(height: 3),
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          if (_size.width < 1050)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  imageString!,
                  width: 20,
                ),
                SizedBox(width: 3),
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            )
        ],
      ),
    );
  }
}
