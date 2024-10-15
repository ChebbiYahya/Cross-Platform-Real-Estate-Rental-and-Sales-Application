import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../controllers/annonce_controller.dart';
import '../../main2/models/scroll_offset.dart';
import '../../main2/widgets/text_reveal.dart';
import '../../models/annonce_model.dart';
import '../home/sections/six_section_page1.dart';
import 'widgets/card_search_widget.dart';

class BlogScreen extends StatefulWidget {
  final String? Category;
  final String? Location;
  final String? Type;
  final bool? homeSearch;
  const BlogScreen(
      {super.key, this.Location, this.Category, this.Type, this.homeSearch});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

List<String> option = ["Vente", "Location"];

class _BlogScreenState extends State<BlogScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controllerList;
  late Animation<double> textRevealAnimation;
  late Animation<double> textOpacityAnimation;
  late Animation<double> descriptionAnimation;
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

  late ScrollController controllerScroll;
  @override
  void initState() {
    controllerScroll = ScrollController();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1700),
        reverseDuration: Duration(milliseconds: 375));
    controllerList = AnimationController(
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
        curve: Interval(0.1, 0.5, curve: Curves.easeOut),
      ),
    );
    descriptionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 0.7, curve: Curves.easeOut),
      ),
    );
    super.initState();
    Future.delayed(Duration(milliseconds: 400), () {
      controller.forward();
    });
    controllerScroll.addListener(() {
      context.read<DisplayOffset>().changeDisplayOffset(
          (MediaQuery.of(context).size.height +
                  controllerScroll.position.pixels)
              .toInt());
    });
  }

  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      controller: controllerScroll,
      child: Container(
        child: Column(
          children: [
            AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Container(
                    padding: _size.width > 600
                        ? EdgeInsets.only(
                            top: 30, bottom: 20, right: 20, left: 20)
                        : EdgeInsets.only(
                            top: 20, bottom: 20, right: 5, left: 5),
                    width: double.infinity,
                    color: kLightBlueColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextReveal(
                          maxHeight: 90,
                          textOpacityAnimation: textOpacityAnimation,
                          textRevealAnimation: textRevealAnimation,
                          controller: controller,
                          child: Text(
                            "RECHERCHE D'UNE OFFRE",
                            style: Theme.of(context).textTheme.headline2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TextReveal(
                          maxHeight: 90,
                          textOpacityAnimation: textOpacityAnimation,
                          textRevealAnimation: textRevealAnimation,
                          controller: controller,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.headline3,
                              children: [
                                TextSpan(text: 'Choisissez Parmi les offres '),
                                TextSpan(
                                  text: 'les plus avantageuses',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: kHoverColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        FadeTransition(
                          opacity: descriptionAnimation,
                          child: Container(
                            width: 800,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: kDefaultPadding),
                            margin: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                                vertical: kDefaultPadding),
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
                            /* decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhiteColor,
                    ),*/
                            child: SizeTransition(
                              sizeFactor: descriptionAnimation,
                              axis: Axis.horizontal,
                              axisAlignment: -1.0,
                              child: Column(
                                children: [
                                  if (_size.width < 650)
                                    Column(
                                      children: [
                                        DropDownListe(
                                            context,
                                            "Ville",
                                            itemsLocation,
                                            dropdownValueLocation,
                                            (String? newValue) {
                                          setState(() {
                                            dropdownValueLocation = newValue;
                                          });
                                        }),
                                        SizedBox(height: kDefaultPadding),
                                        DropDownListe(
                                            context,
                                            "Catégorie",
                                            itemsCategorie,
                                            dropdownValueCategorie,
                                            (String? newValue) {
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
                                              dropdownValueLocation,
                                              (String? newValue) {
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
                                              dropdownValueCategorie,
                                              (String? newValue) {
                                            setState(() {
                                              dropdownValueCategorie = newValue;
                                            });
                                          }),
                                        ),
                                      ],
                                    ),
                                  /* SizedBox(height: kDefaultPadding),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Search ...",
                                  prefixIcon: Icon(Icons.search),
                                ),
                              ),*/
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
                                                currentOption =
                                                    value.toString();
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
                                                currentOption =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      print(
                                          "dropdownValueCategorieS= ${widget.Category}");
                                      print(
                                          "dropdownValueLocationS= ${widget.Location}");
                                      print("currentOptionS= ${widget.Type}");
                                      print(
                                          "Home filter= ${widget.homeSearch}");
                                      setState(() {});
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          ),
                        )
                      ],
                    ),
                  );
                }),
            AnimatedBuilder(
                animation: controllerList,
                builder: (context, child) {
                  return Container(
                    padding: _size.width > 1750
                        ? EdgeInsets.symmetric(horizontal: 40, vertical: 20)
                        : EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        if (_size.width < 350)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 1,
                              childAspectRatio: 0.6,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 350 && _size.width < 400)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 1,
                              childAspectRatio: 0.75,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 400 && _size.width < 450)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 1,
                              childAspectRatio: 0.8,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 450 && _size.width < 500)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 1,
                              childAspectRatio: 0.96,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 500 && _size.width < 550)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 2,
                              childAspectRatio: 0.55,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 550 && _size.width < 650)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 2,
                              childAspectRatio: 0.62,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 650 && _size.width < 720)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 2,
                              childAspectRatio: 0.72,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 720 && _size.width < 750)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 3,
                              childAspectRatio: 0.55,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 750 && _size.width < 850)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 3,
                              childAspectRatio: 0.57,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 850 && _size.width < 950)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 3,
                              childAspectRatio: 0.65,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 950 && _size.width < 1050)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 3,
                              childAspectRatio: 0.72,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 1050 && _size.width < 1170)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 3,
                              childAspectRatio: 0.82,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 1170 && _size.width < 1250)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 3,
                              childAspectRatio: 0.9,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 1250 && _size.width < 1450)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 3,
                              childAspectRatio: 0.96,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 1450 && _size.width < 1650)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 4,
                              childAspectRatio: 0.77,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 1650 && _size.width < 1850)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 5,
                              childAspectRatio: 0.77,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 1850 && _size.width < 2050)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 5,
                              childAspectRatio: 0.82,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 2050 && _size.width < 2250)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 5,
                              childAspectRatio: 0.93,
                              descriptionAnimation: descriptionAnimation),
                        if (_size.width > 2250)
                          ListOfCards(
                              categoryHome: widget.Category,
                              locationHome: widget.Location,
                              typeHome: widget.Type,
                              categorySearch: dropdownValueCategorie,
                              locationSearch: dropdownValueLocation,
                              typeSearch: currentOption,
                              homeSearch: widget.homeSearch,
                              crossAxisCount: 5,
                              childAspectRatio: 1.05,
                              descriptionAnimation: descriptionAnimation),
                        /*  SizedBox(height: 20),
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
                    ),
                  );
                }),
            SizedBox(height: 30),
            if (_size.width > 600) SixSection(),
          ],
        ),
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

class ListOfCards extends StatefulWidget {
  const ListOfCards(
      {super.key,
      required this.childAspectRatio,
      required this.crossAxisCount,
      required this.descriptionAnimation,
      this.homeSearch,
      this.categoryHome,
      this.categorySearch,
      this.locationHome,
      this.locationSearch,
      this.typeHome,
      this.typeSearch});
  final int crossAxisCount;
  final double childAspectRatio;
  final Animation<double> descriptionAnimation;
  final bool? homeSearch;
  final String? categoryHome,
      typeHome,
      locationHome,
      categorySearch,
      typeSearch,
      locationSearch;

  @override
  State<ListOfCards> createState() => _ListOfCardsState();
}

class _ListOfCardsState extends State<ListOfCards> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnnonceController());

    return FutureBuilder<List<Annonce>?>(
        /* future: controller.getAnnonceWithFilter(widget.categorySearch ?? "",
            widget.locationSearch ?? "", widget.typeSearch ?? ""),*/
        future: widget.homeSearch!
            ? controller.getAnnonceWithFilter(widget.categoryHome ?? "",
                widget.locationHome ?? "", widget.typeHome ?? "")
            : controller.getAnnonceWithFilter(widget.categorySearch ?? "",
                widget.locationSearch ?? "", widget.typeSearch ?? ""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.crossAxisCount,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: widget.childAspectRatio),
                itemBuilder: (context, index) => FadeTransition(
                  opacity: widget.descriptionAnimation,
                  child: SizeTransition(
                      sizeFactor: widget.descriptionAnimation,
                      child: CardSearchWidget(annonce: snapshot.data![index])),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(child: Text("Quelque chose n'a pas fonctionné"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
