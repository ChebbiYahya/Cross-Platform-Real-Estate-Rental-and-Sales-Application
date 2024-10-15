import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../constants.dart';
import '../../controllers/annonce_controller.dart';
import '../../models/annonce_model.dart';

class AddAnnonceSection extends StatefulWidget {
  const AddAnnonceSection({super.key});

  @override
  State<AddAnnonceSection> createState() => _AddAnnonceSectionState();
}

List<String> option = ["Vente", "Location"];

class _AddAnnonceSectionState extends State<AddAnnonceSection> {
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  final List<Uint8List> _image = [];
  late Uint8List imageFile;
  bool uploading = false;
  double val = 0;
  String currentOption = option[0];
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
  bool? checkCaract = false,
      checkBalcony = false,
      checkTerace = false,
      checkJardin = false,
      checkArround = false,
      checkfacilities = false,
      checkToKnown = false,
      checkPrice = false,
      checkWifi = false,
      checkAir = false,
      checkElevator = false,
      checkKitchen = false,
      checkParking = false,
      checkTv = false,
      checkOffer = false;

  TextEditingController _citeController = new TextEditingController();
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _totalAreaController = new TextEditingController();
  TextEditingController _UseableAreaController = new TextEditingController();
  TextEditingController _nbRoomsController = new TextEditingController();
  TextEditingController _nbBathroomsController = new TextEditingController();
  TextEditingController _nbGaragesController = new TextEditingController();
  TextEditingController _arroundCityDistanceController =
      new TextEditingController();
  TextEditingController _arroundAirportDistanceController =
      new TextEditingController();
  TextEditingController _arroundAirportNameController =
      new TextEditingController();
  TextEditingController _arroundTrainDistanceController =
      new TextEditingController();
  TextEditingController _arroundTrainNameController =
      new TextEditingController();
  TextEditingController _arroundMetroDistanceController =
      new TextEditingController();
  TextEditingController _arroundMetroNameController =
      new TextEditingController();
  TextEditingController _arroundBusDistanceController =
      new TextEditingController();
  TextEditingController _arroundBusNameController = new TextEditingController();
  TextEditingController _arroundShopDistanceController =
      new TextEditingController();
  TextEditingController _arroundShopNameController =
      new TextEditingController();
  TextEditingController _checkInFromController = new TextEditingController();
  TextEditingController _checkInToController = new TextEditingController();
  TextEditingController _checkOutFromController = new TextEditingController();
  TextEditingController _checkOutToController = new TextEditingController();
  TextEditingController _visitDayFromController = new TextEditingController();
  TextEditingController _visitDayToController = new TextEditingController();
  TextEditingController _visitTimeFromController = new TextEditingController();
  TextEditingController _visitTimeToController = new TextEditingController();
  TextEditingController _overviewsController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnnonceController());

    var _size = MediaQuery.of(context).size;
    return Container(
      height: _size.width < 850 ? _size.height - 108 : null,
      margin: _size.width > 600
          ? EdgeInsets.symmetric(horizontal: 10)
          : EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Ajouter Une Annonce",
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              if (_size.width > 1000) WebAddAnnoce(context),
              if (_size.width < 1000 && _size.width > 600)
                TabletAddAnnoce(context),
              if (_size.width < 600) MobileAddAnnoce(context),
              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _overviewsController,
                maxLines: 2,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.text_snippet_outlined),
                    hintText: "Contenu",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
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
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "Ajouter Images",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 20),
                    Stack(
                      children: [
                        Container(
                          height: 120,
                          child: GridView.builder(
                              itemCount: _image.length + 1,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 10),
                              itemBuilder: (context, index) {
                                return index == 0
                                    ? Center(
                                        child: IconButton(
                                          onPressed: !uploading
                                              ? chooseImageWeb
                                              : null, //chooseImage,
                                          icon: Icon(Icons.add),
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.all(3),
                                        child: Image.memory(
                                          _image[index - 1],
                                          fit: BoxFit.cover,
                                        ),
                                      );
                              }),
                        ),
                        uploading
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        child: Text(
                                      "uploading...",
                                      style: TextStyle(fontSize: 28),
                                    )),
                                    SizedBox(height: 10),
                                    CircularProgressIndicator(
                                      value: val,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.red),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    final annonce = Annonce(
                      categorie: dropdownValueCategorie.toString(),
                      ville: dropdownValueLocation.toString(),
                      cite: _citeController.text,
                      buyOrRent: currentOption.toString(),
                      title: _titleController.text,
                      caract: checkCaract,
                      useableArea: _UseableAreaController.text,
                      totalArea: _totalAreaController.text,
                      nbRooms: _nbRoomsController.text,
                      nbBathrooms: _nbBathroomsController.text,
                      nbGarage: _nbGaragesController.text,
                      bacony: checkBalcony,
                      terace: checkBalcony,
                      jardin: checkJardin,
                      facilities: checkfacilities,
                      wifi: checkWifi,
                      airCond: checkAir,
                      elevator: checkElevator,
                      kitchenFacil: checkKitchen,
                      parking: checkParking,
                      tv: checkTv,
                      offerOrNot: checkOffer,
                      arround: checkArround,
                      aroundAirportDistance:
                          _arroundAirportDistanceController.text,
                      aroundCityDistance: _arroundCityDistanceController.text,
                      aroundAirportName: _arroundAirportNameController.text,
                      aroundTrainDistance: _arroundTrainDistanceController.text,
                      aroundTrainName: _arroundTrainNameController.text,
                      aroundBusDistance: _arroundBusDistanceController.text,
                      aroundBusName: _arroundBusNameController.text,
                      aroundMetroDistance: _arroundMetroDistanceController.text,
                      aroundMetroName: _arroundMetroNameController.text,
                      aroundShopDistance: _arroundShopDistanceController.text,
                      aroundShopName: _arroundShopNameController.text,
                      toKnow: checkToKnown,
                      checkInFrom: _checkInFromController.text,
                      checkInTo: _checkInToController.text,
                      checkOutFrom: _checkOutFromController.text,
                      checkOutTo: _checkOutToController.text,
                      dateVisitIn: _visitDayFromController.text,
                      dateVisitOut: _visitDayToController.text,
                      timeVisitIn: _visitTimeFromController.text,
                      timeVisitOut: _visitTimeToController.text,
                      checkprix: checkPrice,
                      price: _priceController.text,
                      overview: _overviewsController.text,

                      //images
                    );
                    await controller
                        .createAnnonce(annonce, _image)
                        .then((value) {
                      Fluttertoast.showToast(msg: "Annonce Ajoutée");
                    });
                  }
                },
                child: Text(
                  "Save",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  IntrinsicHeight WebAddAnnoce(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        DropDownListe(context, "Categorie", itemsCategorie,
                            dropdownValueCategorie, (String? newValue) {
                          setState(() {
                            dropdownValueCategorie = newValue;
                          });
                        }),
                        SizedBox(height: 20),
                        DropDownListe(context, "ville", itemsLocation,
                            dropdownValueLocation, (String? newValue) {
                          setState(() {
                            dropdownValueLocation = newValue;
                          });
                        }),
                        SizedBox(height: 20),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _citeController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.share_location),
                              hintText: "cité",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Vente",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _titleController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.subtitles),
                              hintText: "Titre ",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkCaract,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkCaract = newBool;
                                  });
                                }),
                            Expanded(
                              child: Text(
                                "Caractéristiques Générales",
                                style: Theme.of(context).textTheme.headline4,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _totalAreaController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.square_foot_rounded),
                              hintText: "Surface totale(500m²)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _UseableAreaController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.square_foot_rounded),
                              hintText: "Surface utilisable(300m²)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _nbRoomsController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.bedroom_parent_outlined),
                              hintText: "Nombre de chambres(3)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _nbBathroomsController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.bathroom_outlined),
                              hintText: "Nombre de salles de bains(2)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _nbGaragesController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.directions_car_filled_outlined),
                              hintText: "Nombre de garages(2)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkBalcony,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkBalcony = newBool;
                                  });
                                }),
                            Text(
                              "Balcon",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkTerace,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkTerace = newBool;
                                  });
                                }),
                            Text(
                              "Terace",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkJardin,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkJardin = newBool;
                                  });
                                }),
                            Text(
                              "Jardin",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  /* SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkfacilities,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkfacilities = newBool;
                                  });
                                }),
                            Text(
                              "Facilités",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkWifi,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkWifi = newBool;
                                  });
                                }),
                            Text(
                              "Wifi",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkAir,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkAir = newBool;
                                  });
                                }),
                            Text(
                              "Climatiseur",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkElevator,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkElevator = newBool;
                                  });
                                }),
                            Text(
                              "Ascenseur",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkKitchen,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkKitchen = newBool;
                                  });
                                }),
                            Text(
                              "Équipements de cuisine",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkParking,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkParking = newBool;
                                  });
                                }),
                            Text(
                              "Parking",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkTv,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkTv = newBool;
                                  });
                                }),
                            Text(
                              "Tv",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )*/
                ],
              ),
            ),
          ),
          VerticalDivider(
            width: 20,
            color: Colors.grey,
            thickness: 2,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkArround,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkArround = newBool;
                                  });
                                }),
                            Text(
                              "Autour",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 3),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundCityDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.share_location),
                              hintText: "Distance Centre Ville(500m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundAirportDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.connecting_airports_outlined),
                              hintText: "Distance Airport(12km)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundAirportNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.connecting_airports_outlined),
                              hintText: "Nom Airport(Tunis Carthage)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundTrainDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Distance Station Train(700m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundTrainNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Nom Station Train(Barcelone)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundMetroDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Distance Station Metro(200m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundMetroNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Nom Station Metro(Barcelone)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundBusDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.directions_bus_filled_outlined),
                              hintText: "Distance Station Bus(170m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundBusNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.directions_bus_filled_outlined),
                              hintText: "Nom Station Bus(Barcelone)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundShopDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.shopping_cart_outlined),
                              hintText: "Distance Magasin(300m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundShopNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.shopping_cart_outlined),
                              hintText: "Nom Magasin(MG)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(height: 20),
                ],
              ),
            ),
          ),
          VerticalDivider(
            width: 20,
            color: Colors.grey,
            thickness: 2,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkToKnown,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkToKnown = newBool;
                                  });
                                }),
                            Text(
                              "A savoir(Par Nuitée)",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        Text(
                          "Arrivée",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkInFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "De (10:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkInToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "Jusqu'à (23:59)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Sortie",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkOutFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "De (00:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkOutToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "Jusqu'à (10:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Text(
                          "Temps de visite",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        Text(
                          "Jours",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitDayFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.calendar_month_outlined),
                                    hintText: "De (Lundi)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitDayToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.calendar_month_outlined),
                                    hintText: "Jusqu'à (Samedi)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "L'heure",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitTimeFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "De (08:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitTimeToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "Jusqu'à (18:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkPrice,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkPrice = newBool;
                                  });
                                }),
                            Text(
                              "Prix",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _priceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.attach_money_rounded),
                              hintText: "Prix (1200dt)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkOffer,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkOffer = newBool;
                                  });
                                }),
                            Text(
                              "Offer",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IntrinsicHeight MobileAddAnnoce(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        DropDownListe(context, "Categorie", itemsCategorie,
                            dropdownValueCategorie, (String? newValue) {
                          setState(() {
                            dropdownValueCategorie = newValue;
                          });
                        }),
                        SizedBox(height: 20),
                        DropDownListe(context, "Ville", itemsLocation,
                            dropdownValueLocation, (String? newValue) {
                          setState(() {
                            dropdownValueLocation = newValue;
                          });
                        }),
                        SizedBox(height: 20),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _citeController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.share_location),
                              hintText: "cité",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Vente",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _titleController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.subtitles),
                              hintText: "Titre ",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkCaract,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkCaract = newBool;
                                  });
                                }),
                            Expanded(
                              child: Text(
                                "Caractéristiques Générales",
                                style: Theme.of(context).textTheme.headline4,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _totalAreaController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.square_foot_rounded),
                              hintText: "Surface totale(500m²)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _UseableAreaController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.square_foot_rounded),
                              hintText: "Surface utilisable(300m²)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _nbRoomsController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.bedroom_parent_outlined),
                              hintText: "Nombre de chambres(3)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _nbBathroomsController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.bathroom_outlined),
                              hintText: "Nombre de salles de bains(2)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _nbGaragesController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.directions_car_filled_outlined),
                              hintText: "Nombre de garages(2)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkBalcony,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkBalcony = newBool;
                                  });
                                }),
                            Text(
                              "Balcon",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkTerace,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkTerace = newBool;
                                  });
                                }),
                            Text(
                              "Terace",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkJardin,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkJardin = newBool;
                                  });
                                }),
                            Text(
                              "Jardin",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkArround,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkArround = newBool;
                                  });
                                }),
                            Text(
                              "Autour",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundCityDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.share_location),
                              hintText: "Distance Centre Ville(500m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundAirportDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.connecting_airports_outlined),
                              hintText: "Distance Airport(12km)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundAirportNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.connecting_airports_outlined),
                              hintText: "Nom Airport(Tunis Carthage)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundTrainDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Distance Station Train(700m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundTrainNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Nom Station Train(Barcelone)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundMetroDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Distance Station Metro(200m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundMetroNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Nom Station Metro(Barcelone)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundBusDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.directions_bus_filled_outlined),
                              hintText: "Distance Station Bus(170m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundBusNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.directions_bus_filled_outlined),
                              hintText: "Nom Station Bus(Barcelone)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundShopDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.shopping_cart_outlined),
                              hintText: "Distance Magasin(300m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundShopNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.shopping_cart_outlined),
                              hintText: "Nom Magasin(MG)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkfacilities,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkfacilities = newBool;
                                  });
                                }),
                            Text(
                              "Facilités",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkWifi,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkWifi = newBool;
                                  });
                                }),
                            Text(
                              "Wifi",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkAir,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkAir = newBool;
                                  });
                                }),
                            Text(
                              "Climatiseur",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkElevator,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkElevator = newBool;
                                  });
                                }),
                            Text(
                              "Ascenseur",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkKitchen,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkKitchen = newBool;
                                  });
                                }),
                            Text(
                              "Équipements de cuisine",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkParking,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkParking = newBool;
                                  });
                                }),
                            Text(
                              "Parking",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkTv,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkTv = newBool;
                                  });
                                }),
                            Text(
                              "Tv",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),*/
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkToKnown,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkToKnown = newBool;
                                  });
                                }),
                            Text(
                              "A savoir",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        Text(
                          "Arrivée",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkInFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "De (10:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkInToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "Jusqu'à (23:59)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Sortie",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkOutFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "De (00:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkOutToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "Jusqu'à (10:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Text(
                          "Temps de visite",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        Text(
                          "Jours",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitDayFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.calendar_month_outlined),
                                    hintText: "De (Lundi)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitDayToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.calendar_month_outlined),
                                    hintText: "Jusqu'à (Samedi)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "L'heure",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitTimeFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "De (08:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitTimeToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "Jusqu'à (18:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkPrice,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkPrice = newBool;
                                  });
                                }),
                            Text(
                              "Prix",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _priceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.attach_money_rounded),
                              hintText: "Prix (1200dt)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkOffer,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkOffer = newBool;
                                  });
                                }),
                            Text(
                              "Offer",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IntrinsicHeight TabletAddAnnoce(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        DropDownListe(context, "Categorie", itemsCategorie,
                            dropdownValueCategorie, (String? newValue) {
                          setState(() {
                            dropdownValueCategorie = newValue;
                          });
                        }),
                        SizedBox(height: 20),
                        DropDownListe(context, "ville", itemsLocation,
                            dropdownValueLocation, (String? newValue) {
                          setState(() {
                            dropdownValueLocation = newValue;
                          });
                        }),
                        SizedBox(height: 20),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _citeController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.share_location),
                              hintText: "cité",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Vente",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                  "location",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _titleController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.subtitles),
                              hintText: "Titre ",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkCaract,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkCaract = newBool;
                                  });
                                }),
                            Expanded(
                              child: Text(
                                "Caractéristiques Générales",
                                style: Theme.of(context).textTheme.headline4,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _totalAreaController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.square_foot_rounded),
                              hintText: "Surface totale(500m²)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _UseableAreaController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.square_foot_rounded),
                              hintText: "Surface utilisable(300m²)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _nbRoomsController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.bedroom_parent_outlined),
                              hintText: "Nombre de chambres(3)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _nbBathroomsController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.bathroom_outlined),
                              hintText: "Nombre de salles de bains(2)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _nbGaragesController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.directions_car_filled_outlined),
                              hintText: "Nombre de garages(2)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkBalcony,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkBalcony = newBool;
                                  });
                                }),
                            Text(
                              "Balcon",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkTerace,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkTerace = newBool;
                                  });
                                }),
                            Text(
                              "Terace",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkJardin,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkJardin = newBool;
                                  });
                                }),
                            Text(
                              "Jardin",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkArround,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkArround = newBool;
                                  });
                                }),
                            Text(
                              "Autour",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 3),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundCityDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.share_location),
                              hintText: "Distance Centre Ville(500m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundAirportDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.connecting_airports_outlined),
                              hintText: "Distance Airport(12km)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundAirportNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.connecting_airports_outlined),
                              hintText: "Nom Airport(Tunis Carthage)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundTrainDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Distance Station Train(700m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundTrainNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Nom Station Train(Barcelone)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundMetroDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Distance Station Metro(200m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundMetroNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                  Icons.directions_transit_filled_outlined),
                              hintText: "Nom Station Metro(Barcelone)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundBusDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.directions_bus_filled_outlined),
                              hintText: "Distance Station Bus(170m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundBusNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.directions_bus_filled_outlined),
                              hintText: "Nom Station Bus(Barcelone)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        Divider(),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundShopDistanceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.shopping_cart_outlined),
                              hintText: "Distance Magasin(300m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _arroundShopNameController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.shopping_cart_outlined),
                              hintText: "Nom Magasin(MG)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            width: 20,
            color: Colors.grey,
            thickness: 2,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  /*Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkfacilities,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkfacilities = newBool;
                                  });
                                }),
                            Text(
                              "facilités",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                value: checkWifi,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkWifi = newBool;
                                  });
                                }),
                            Text(
                              "Wifi",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkAir,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkAir = newBool;
                                  });
                                }),
                            Text(
                              "Climatiseur",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkElevator,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkElevator = newBool;
                                  });
                                }),
                            Text(
                              "Ascenseur",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkKitchen,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkKitchen = newBool;
                                  });
                                }),
                            Text(
                              "Équipements de cuisine",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkParking,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkParking = newBool;
                                  });
                                }),
                            Text(
                              "Parking",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                                value: checkTv,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkTv = newBool;
                                  });
                                }),
                            Text(
                              "Tv",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),*/
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkToKnown,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkToKnown = newBool;
                                  });
                                }),
                            Text(
                              "A savoir",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        Text(
                          "Arrivée",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkInFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "De (10:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkInToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "Jusqu'à (23:59)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Sortie",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkOutFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "De (00:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _checkOutToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "Jusqu à (10:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Text(
                          "Temps de visite",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        Text(
                          "Jours",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitDayFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.calendar_month_outlined),
                                    hintText: "De (Lundi)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitDayToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.calendar_month_outlined),
                                    hintText: "Jusqu'à (Samedi)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "L'heure",
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitTimeFromController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "De (08:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _visitTimeToController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.access_time),
                                    hintText: "Jusqu'à (18:00)",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkPrice,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkPrice = newBool;
                                  });
                                }),
                            Text(
                              "Prix",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _priceController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.attach_money_rounded),
                              hintText: "Prix (1200dt)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
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
                        Row(
                          children: [
                            Checkbox(
                                value: checkOffer,
                                tristate: false,
                                activeColor: kDarkBlueColor,
                                onChanged: (newBool) {
                                  setState(() {
                                    checkOffer = newBool;
                                  });
                                }),
                            Text(
                              "Offre",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownButtonFormField<String> DropDownListe(
      BuildContext context,
      String title,
      List<String> items,
      String? value,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      validator: MultiValidator(
        [
          RequiredValidator(errorText: "* Required"),
        ],
      ),
      hint: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
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
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(value, style: Theme.of(context).textTheme.headline5!),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  chooseImageWeb() async {
    final image = await ImagePickerWeb.getImageAsBytes();
    setState(() {
      imageFile = image!;

      _image.add(imageFile);
    });
  }
}
