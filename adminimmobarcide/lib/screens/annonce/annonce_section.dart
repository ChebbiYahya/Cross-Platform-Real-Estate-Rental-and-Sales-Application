import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../controllers/annonce_controller.dart';
import '../../models/annonce_model.dart';

class AnnonceSection extends StatefulWidget {
  const AnnonceSection({super.key});

  @override
  State<AnnonceSection> createState() => _AnnonceSectionState();
}

List<String> option = ["Vente", "Location"];

class _AnnonceSectionState extends State<AnnonceSection>
    with TickerProviderStateMixin {
  late ScrollController controller;
  String currentOption = option[0];
  String? dropdownValueLocation;
  List<String> itemsLocation = [
    'Ariana',
    'Ben Arous',
    'Bizerte',
    'Béja',
    'Gabès',
    'Gafsa',
    'Jendouba',
    'Kairouan',
    'Kasserine',
    'Kébili',
    'La Manouba',
    'Le Kef',
    'Mahdia',
    'Monastir',
    'Médenine',
    'Nabeul',
    'Sfax',
    'Sidi Bouzid',
    'Siliana',
    'Sousse',
    'Tataouine',
    'Tozeur',
    'Tunis',
    'Zaghouan',
  ];
  String? dropdownValueCategorie;
  List<String> itemsCategorie = [
    'Colocations',
    'Maisons et villas',
    'Magasins,Commerces ',
    'Locations de vacances',
    'Appartements',
    'Bureaux et Plateax',
    'Autres Immobilires',
    'Terrains et Fermes',
  ];

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final controller = Get.put(AnnonceController());
    return SingleChildScrollView(
      child: Container(
          // height: _size.width < 850 ? _size.height - 108 : null,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Annonces",
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              Container(
                //width: 700,
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: kDefaultPadding),
                margin: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding),
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(10),
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
                    if (_size.width < 650)
                      Column(
                        children: [
                          DropDownListe(context, "Ville", itemsLocation,
                              dropdownValueLocation, (String? newValue) {
                            setState(() {
                              dropdownValueLocation = newValue;
                            });
                          }),
                          SizedBox(height: kDefaultPadding),
                          DropDownListe(context, "Catégorie", itemsCategorie,
                              dropdownValueCategorie, (String? newValue) {
                            setState(() {
                              dropdownValueCategorie = newValue;
                            });
                          }),
                        ],
                      ),
                    if (_size.width > 650)
                      Row(
                        children: [
                          Expanded(
                            child: DropDownListe(
                                context,
                                "Ville",
                                itemsLocation,
                                dropdownValueLocation, (String? newValue) {
                              setState(() {
                                dropdownValueLocation = newValue;
                              });
                            }),
                          ),
                          SizedBox(width: kDefaultPadding),
                          Expanded(
                            child: DropDownListe(
                                context,
                                "Catégorie",
                                itemsCategorie,
                                dropdownValueCategorie, (String? newValue) {
                              setState(() {
                                dropdownValueCategorie = newValue;
                              });
                            }),
                          ),
                        ],
                      ),

                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "Vente",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: kBlueColor),
                            ),
                            leading: Radio(
                              value: option[0],
                              activeColor: kBlueColor,
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "Location",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: kBlueColor),
                            ),
                            leading: Radio(
                              value: option[1],
                              activeColor: kBlueColor,
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(height: kDefaultPadding),
                    ElevatedButton(
                      onPressed: () {
                        controller.getAllAnnonceInfo();
                        print(
                            "dropdownValueCategorie= $dropdownValueCategorie");
                        print("dropdownValueLocation= $dropdownValueLocation");
                        print("currentOption= $currentOption");
                        setState(() {});
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 5),
                          Text(
                            "Rechercher",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 500,
                child: FutureBuilder<List<Annonce>?>(
                    future: controller.getAnnonceWithFilter(
                        dropdownValueCategorie ?? "",
                        dropdownValueLocation ?? "",
                        currentOption ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return _size.width > 600
                                  ? WebCardOnHolding(
                                      annonce: snapshot.data![index])
                                  : MobileCardOnHolding(
                                      annonce: snapshot.data![index]);
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return Center(child: Text("Something went wrong"));
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              /*SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: kHoverColor,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      size: 30,
                      color: kHoverColor,
                    ),
                  ),
                ],
              ),*/
            ],
          )),
    );
  }

  DropdownButtonFormField<String> DropDownListe(
      BuildContext context,
      String title,
      List<String> items,
      String? value,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      hint: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          children: [
            Icon(Icons.location_on, color: kBlueColor),
            SizedBox(width: 5),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: kBlueColor)),
          ],
        ),
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: kBlueColor),
        ),
      ),
      value: value,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(value, style: Theme.of(context).textTheme.headline5!),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class MobileCardOnHolding extends StatefulWidget {
  const MobileCardOnHolding({
    super.key,
    required this.annonce,
  });
  final Annonce annonce;

  @override
  State<MobileCardOnHolding> createState() => _MobileCardOnHoldingState();
}

class _MobileCardOnHoldingState extends State<MobileCardOnHolding> {
  String currentOption = option[0];
  final controller = Get.put(AnnonceController());
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(20),
      padding: _size.width > 450 ? EdgeInsets.all(20) : EdgeInsets.all(10),
      width: double.infinity,
      height: 470,
      decoration: BoxDecoration(
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
              borderRadius: BorderRadius.circular(10), // Image border
              child: Image.network(
                widget.annonce.images![0],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.annonce.title} ${widget.annonce.title}",
                    style: Theme.of(context).textTheme.headline4,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${widget.annonce.ville},${widget.annonce.cite}",
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (widget.annonce.nbRooms != "0")
                        CaractresticImage(
                            imageString: "assets/images/ad_icons/bed.svg",
                            title: "${widget.annonce.nbRooms} Chambres"),
                      if (widget.annonce.nbBathrooms != "0")
                        CaractresticImage(
                            imageString: "assets/images/ad_icons/bath.svg",
                            title: "${widget.annonce.nbBathrooms} Toilettes"),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (widget.annonce.nbGarage != "0")
                        CaractresticImage(
                            imageString: "assets/images/ad_icons/car.svg",
                            title: "${widget.annonce.nbGarage} Garages"),
                      CaractresticImage(
                          imageString:
                              "assets/images/ad_icons/angularRuler.svg",
                          title: "${widget.annonce.totalArea}"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller
                              .deleteAnnonce(widget.annonce.id)
                              .whenComplete(() =>
                                  Fluttertoast.showToast(msg: "Supprimée"));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        child: Text(
                          "Supprimer",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WebCardOnHolding extends StatefulWidget {
  const WebCardOnHolding({
    super.key,
    required this.annonce,
  });

  final Annonce annonce;

  @override
  State<WebCardOnHolding> createState() => _WebCardOnHoldingState();
}

class _WebCardOnHoldingState extends State<WebCardOnHolding> {
  final controller = Get.put(AnnonceController());
  String currentOption = option[0];
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
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
      width: double.infinity,
      // height: 400,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border
              child: /*FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.annonce.images![0],
                  fit: BoxFit.cover,
                )*/
                  Image.network(
                widget.annonce.images![0],
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),
          Expanded(
              flex: _size.width > 1150 ? 4 : 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.annonce.title!,
                      style: Theme.of(context).textTheme.headline3,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${widget.annonce.ville},${widget.annonce.cite}",
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (widget.annonce.nbRooms != "")
                          CaractresticImage(
                              imageString: "assets/images/ad_icons/bed.svg",
                              title: "${widget.annonce.nbRooms} Chambres"),
                        if (widget.annonce.nbBathrooms != "")
                          CaractresticImage(
                              imageString: "assets/images/ad_icons/bath.svg",
                              title: "${widget.annonce.nbBathrooms} Toilettes"),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (widget.annonce.nbGarage != "")
                          CaractresticImage(
                              imageString: "assets/images/ad_icons/car.svg",
                              title: "${widget.annonce.nbGarage} Garages"),
                        if (widget.annonce.totalArea != "")
                          CaractresticImage(
                              imageString:
                                  "assets/images/ad_icons/angularRuler.svg",
                              title: "${widget.annonce.totalArea}"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            controller
                                .deleteAnnonce(widget.annonce.id)
                                .whenComplete(() =>
                                    Fluttertoast.showToast(msg: "Supprimée"));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent),
                          child: Text(
                            "Supprimer",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
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
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imageString!,
                width: 22,
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
