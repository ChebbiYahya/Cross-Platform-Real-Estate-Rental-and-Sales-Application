import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../text_reveal.dart';

class FirstSection extends StatefulWidget {
  final void Function(int)? onTabChangedWeb;
  final void Function(int)? onTabChangedMobile;
  final void Function(String)? onTabChangedFilterLocation;
  final void Function(String)? onTabChangedFilterCategory;
  final void Function(String)? onTabChangedFilterType;
  final void Function(bool)? onTabChangedHomeFilter;

  const FirstSection({
    super.key,
    this.onTabChangedWeb,
    this.onTabChangedMobile,
    this.onTabChangedFilterCategory,
    this.onTabChangedFilterLocation,
    this.onTabChangedFilterType,
    this.onTabChangedHomeFilter,
  });

  @override
  State<FirstSection> createState() => _FirstSectionState();
}

List<String> option = ["Vente", "Location"];

class _FirstSectionState extends State<FirstSection>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> ImageReveal;
  late Animation<double> textRevealAnimation;
  late Animation<double> textOpacityAnimation;
  late Animation<double> descriptionAnimation;
  late Animation<double> imageRevealAnimation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1700),
        reverseDuration: Duration(milliseconds: 375));
    textRevealAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.3, 0.6, curve: Curves.easeOut),
      ),
    );
    textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );
    descriptionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 0.7, curve: Curves.easeOut),
      ),
    );
    ImageReveal = Tween<double>(begin: 600.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );
    imageRevealAnimation = Tween<double>(begin: 500.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    super.initState();
    Future.delayed(Duration(milliseconds: 400), () {
      controller.forward();
    });
  }

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
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            alignment: Alignment.center,
            height: 700,
            child: Stack(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/headerPicture.png",
                        fit: BoxFit.cover,
                        height: 700,
                        width: double.infinity,
                      ),
                    ),
                    AnimatedBuilder(
                      animation: imageRevealAnimation,
                      builder: (context, child) {
                        return Container(
                          height: imageRevealAnimation.value,
                          width: double.infinity,
                          color: Colors.white,
                          alignment: Alignment(0.0, -1.0),
                        );
                      },
                    ),
                    /* Container(
                      height: ImageReveal.value,
                      width: double.infinity,
                      color: Colors.white,
                    ),*/
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //SizedBox(height: kDefaultPadding),
                      TextReveal(
                        maxHeight: 90,
                        textOpacityAnimation: textOpacityAnimation,
                        textRevealAnimation: textRevealAnimation,
                        controller: controller,
                        child: Text(
                          "NOUS SOMMES UN LEADER",
                          style: Theme.of(context).textTheme.headline1,
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
                              style: Theme.of(context).textTheme.headline1,
                              children: [
                                TextSpan(text: 'IMMOBILIER '),
                                TextSpan(
                                  text: 'AGENCE',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(color: kHoverColor),
                                ),
                              ]),
                        ),
                      ),
                      //SizedBox(height: 40),
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
                            borderRadius: BorderRadius.circular(10),
                            color: kLightBlueColor,
                          ),
                          child: SizeTransition(
                            sizeFactor: descriptionAnimation,
                            axis: Axis.horizontal,
                            axisAlignment: -1.0,
                            child: Column(
                              children: [
                                if (_size.width < 650)
                                  Column(
                                    children: [
                                      DropDownListe(context, "Ville",
                                          itemsLocation, dropdownValueLocation,
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
                                    widget.onTabChangedWeb!(1);
                                    widget.onTabChangedMobile!(1);
                                    widget.onTabChangedHomeFilter!(true);
                                    widget.onTabChangedFilterLocation!(
                                        dropdownValueLocation!);
                                    widget.onTabChangedFilterCategory!(
                                        dropdownValueCategorie!);
                                    widget
                                        .onTabChangedFilterType!(currentOption);

                                    widget.onTabChangedHomeFilter!(false);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
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
