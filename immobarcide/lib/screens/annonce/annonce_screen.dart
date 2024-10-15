import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:immobarcide/screens/annonce/widgets/book_visit.dart';
import '../../constants.dart';
import '../../models/annonce_model.dart';
import 'widgets/around_widget.dart';
import 'widgets/caracteristic_widget.dart';
import 'widgets/contact_widget.dart';
import 'widgets/details_widget.dart';
import 'widgets/icon_details_widget.dart';
import 'widgets/image_widget.dart';
import 'widgets/to_know.dart';

class AnnonceScreen extends StatefulWidget {
  AnnonceScreen({required this.annonce, super.key});
  final Annonce annonce;

  @override
  State<AnnonceScreen> createState() => _AnnonceScreenState();
}

class _AnnonceScreenState extends State<AnnonceScreen> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/logo.svg"),
            Text("MyHouse", style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: _size.width > 1250
                  ? EdgeInsets.symmetric(horizontal: 100, vertical: 20)
                  : EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_size.width > 1200)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Text(
                                    widget.annonce.title!,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.fade,
                                  ),
                                  ImageWidget(
                                    annonce: widget.annonce,
                                  ),
                                  DetailsTablet(
                                    annonce: widget.annonce,
                                  ),
                                  // Price(price: "807.57 €/ month"),
                                  /* SizedBox(height: 20),
                                  if (widget.annonce.facilities == true)
                                    FacilitiesWidget(annonce: widget.annonce),*/
                                  SizedBox(height: 20),
                                  DescriptionTextWidget(
                                    title: "Description",
                                    subtitle: widget.annonce.overview,
                                  ),
                                  SizedBox(height: 20),
                                  BookVisit(annonce: widget.annonce),
                                  /*  DescriptionTextWidget(
                                    title: "Location",
                                    subtitle:
                                        "The 100 ft² Unique Cozy Scenic Penthouse apartment lies within 0.8 miles of Olympic and Sports Museum Joan Antonio Samaranch and only 5 minutes' walk from Espanya metro station. This apartment can accommodate a maximum of 7 persons and consists of 3 bedrooms and 1 bathroom.",
                                  ),
                                  SizedBox(height: 20),
                                  DescriptionTextWidget(
                                    title: "Guest Parking",
                                    subtitle:
                                        "Public parking is possible at a location nearby (reservation might be needed) at EUR 25 per day.",
                                  ),*/
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  // DetailsWidget(),
                                  //SizedBox(height: 20),
                                  CaracteristicWidget(
                                    annonce: widget.annonce,
                                  ),
                                  SizedBox(height: 20),
                                  AroundWidget(annonce: widget.annonce),
                                  SizedBox(height: 20),
                                  if (widget.annonce.toKnow == true)
                                    ToKnow(annonce: widget.annonce),
                                  SizedBox(height: 20),
                                  ContactWidget(),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  if (_size.width > 750 && _size.width < 1250)
                    Column(
                      children: [
                        Text(
                          widget.annonce.title!,
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                        ),
                        ImageWidget(annonce: widget.annonce),
                        DetailsTablet(annonce: widget.annonce),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    CaracteristicWidget(
                                        annonce: widget.annonce),
                                    SizedBox(height: 20),
                                    if (widget.annonce.toKnow == true)
                                      ToKnow(annonce: widget.annonce),
                                    //SizedBox(height: 20),
                                  ],
                                )),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    AroundWidget(annonce: widget.annonce),

                                    // SizedBox(height: 20),

                                    // Price(price: "807.57 €/ month"),
                                  ],
                                )),
                          ],
                        ),
                        /* if (widget.annonce.facilities == true)
                          SizedBox(height: 20),
                        if (widget.annonce.facilities == true)
                          FacilitiesWidget(annonce: widget.annonce),*/
                        SizedBox(height: 20),
                        DescriptionTextWidget(
                          title: "Description",
                          subtitle: widget.annonce.overview!,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: BookVisit(annonce: widget.annonce),
                            ),
                            Expanded(
                              flex: 3,
                              child: ContactWidget(),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        /*DescriptionTextWidget(
                          title: "Location",
                          subtitle:
                              "The 100 ft² Unique Cozy Scenic Penthouse apartment lies within 0.8 miles of Olympic and Sports Museum Joan Antonio Samaranch and only 5 minutes' walk from Espanya metro station. This apartment can accommodate a maximum of 7 persons and consists of 3 bedrooms and 1 bathroom.",
                        ),
                        SizedBox(height: 20),
                        DescriptionTextWidget(
                          title: "Guest Parking",
                          subtitle:
                              "Public parking is possible at a location nearby (reservation might be needed) at EUR 25 per day.",
                        ),*/
                      ],
                    ),
                  if (_size.width < 750)
                    Column(
                      children: [
                        Text(
                          widget.annonce.title!,
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                        ),
                        ImageWidget(annonce: widget.annonce),
                        if (_size.width > 500)
                          DetailsTablet(annonce: widget.annonce),
                        if (_size.width < 500)
                          DetailsWidget(annonce: widget.annonce),
                        SizedBox(height: 20),
                        CaracteristicWidget(annonce: widget.annonce),
                        SizedBox(height: 20),
                        AroundWidget(annonce: widget.annonce),
                        if (widget.annonce.toKnow == true) SizedBox(height: 20),
                        if (widget.annonce.toKnow == true)
                          ToKnow(annonce: widget.annonce),
                        /*if (widget.annonce.facilities == true)
                          SizedBox(height: 20),
                        if (widget.annonce.facilities == true)
                          FacilitiesWidget(annonce: widget.annonce),*/
                        SizedBox(height: 20),
                        DescriptionTextWidget(
                          title: "Description",
                          subtitle: widget.annonce.overview!,
                        ),
                        SizedBox(height: 20),
                        BookVisit(annonce: widget.annonce),
                        SizedBox(height: 20),
                        ContactWidget(),
                        SizedBox(height: 20),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsTablet extends StatelessWidget {
  const DetailsTablet({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Détails",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w800, fontSize: 18),
            textAlign: TextAlign.start,
          ),
          Divider(thickness: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconDetailsWidget(
                iconString: "assets/images/ad_icons/flat.svg",
                title: annonce.categorie,
              ),
              SizedBox(width: 5),
              IconDetailsWidget(
                iconString: "assets/images/ad_icons/size.svg",
                title: annonce.totalArea,
              ),
              SizedBox(width: 5),
              IconDetailsWidget(
                iconString: "assets/images/ad_icons/geolocalisation.svg",
                title: annonce.ville,
                subtitle: annonce.cite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DescriptionTextWidget extends StatelessWidget {
  const DescriptionTextWidget({
    this.title,
    this.subtitle,
    super.key,
  });
  final String? title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        //color: kLightBlueColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w800, fontSize: 24),
              textAlign: TextAlign.start,
              overflow: TextOverflow.fade,
            ),
          ),
          SizedBox(height: 10),
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
