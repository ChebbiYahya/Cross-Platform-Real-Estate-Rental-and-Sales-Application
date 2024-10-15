import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../controllers/authentification_controller.dart';
import '../../../models/user_model.dart';

class WebSideMenu extends StatefulWidget {
  const WebSideMenu({
    required this.pressLogout,
    required this.pressResevation,
    required this.pressSettings,
    required this.pressContact,
    required this.index,
    super.key,
  });
  final VoidCallback pressResevation, pressContact, pressSettings, pressLogout;
  final int index;
  @override
  State<WebSideMenu> createState() => _WebSideMenuState();
}

class _WebSideMenuState extends State<WebSideMenu> {
  final controller = Get.put(AuthentificationController());

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Drawer(
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: controller.getUserDetailsController(),
            builder: (context, snapshot) {
              //  if (snapshot.hasData) {
              // UserModel user = snapshot.data as UserModel;
              return Column(
                children: [
                  DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: const Image(
                                  image: AssetImage(
                                      "assets/images/profile_pic.png"))),
                        ),
                        SizedBox(height: 10),
                        /*Text(
                          "yahya chebbi",
                          //user.fullName,
                          textAlign: TextAlign.center,
                          style: _size.width > 650
                              ? Theme.of(context).textTheme.headline4!.copyWith(
                                    color: kBlueColor,
                                  )
                              : Theme.of(context).textTheme.headline5!.copyWith(
                                    color: kBlueColor,
                                  ),
                        ),*/
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: widget.pressResevation,
                    horizontalTitleGap: 10.0,
                    leading: Icon(Icons.space_dashboard_outlined,
                        color: kBlueColor, size: widget.index == 0 ? 30 : 25),
                    title: Text(
                      "Réservations",
                      style: widget.index == 0
                          ? Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: kBlueColor)
                          : Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kBlueColor),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: widget.pressSettings,
                    horizontalTitleGap: 10.0,
                    leading: Icon(Icons.settings_outlined,
                        color: kBlueColor, size: widget.index == 1 ? 30 : 25),
                    title: Text(
                      "Paramètres",
                      style: widget.index == 1
                          ? Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: kBlueColor)
                          : Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kBlueColor),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: widget.pressContact,
                    horizontalTitleGap: 10.0,
                    leading: Icon(Icons.contact_phone_outlined,
                        color: kBlueColor, size: widget.index == 2 ? 30 : 25),
                    title: Text(
                      "Contact",
                      style: widget.index == 2
                          ? Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: kBlueColor)
                          : Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kBlueColor),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    onTap: widget.pressLogout,
                    horizontalTitleGap: 10.0,
                    leading: Icon(Icons.logout_outlined,
                        color: kBlueColor, size: widget.index == 3 ? 30 : 25),
                    title: Text(
                      "Déconnexion",
                      style: widget.index == 3
                          ? Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: kBlueColor)
                          : Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kBlueColor),
                    ),
                  ),
                ],
              );
              /*  } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                // Center(child: Text("Something went wrong"));
                // return const Center(child: CircularProgressIndicator());
                return const Center(child: Text("Something went wrong"));
              }*/
            }),
      ),
    );
  }
}

class MobileSideMenu extends StatefulWidget {
  const MobileSideMenu({
    required this.pressLogout,
    required this.pressResevation,
    required this.pressSettings,
    required this.pressContact,
    required this.index,
    super.key,
  });
  final VoidCallback pressResevation, pressContact, pressSettings, pressLogout;
  final int index;

  @override
  State<MobileSideMenu> createState() => _MobileSideMenuState();
}

class _MobileSideMenuState extends State<MobileSideMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: widget.pressResevation,
                child: Column(
                  children: [
                    Icon(Icons.space_dashboard_outlined,
                        color: kBlueColor, size: widget.index == 0 ? 20 : 15),
                    SizedBox(height: 5),
                    Text(
                      "Reservation",
                      style: widget.index == 0
                          ? Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kBlueColor)
                          : Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: kBlueColor),
                    ),
                  ],
                ),
              ),
              //SizedBox(width: 20),
              InkWell(
                onTap: widget.pressSettings,
                child: Column(
                  children: [
                    Icon(Icons.settings_outlined,
                        color: kBlueColor, size: widget.index == 1 ? 20 : 15),
                    SizedBox(height: 5),
                    Text(
                      "Paramètres",
                      style: widget.index == 1
                          ? Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kBlueColor)
                          : Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: kBlueColor),
                    ),
                  ],
                ),
              ),
              // SizedBox(width: 20),
              InkWell(
                onTap: widget.pressContact,
                child: Column(
                  children: [
                    Icon(Icons.contact_phone_outlined,
                        color: kBlueColor, size: widget.index == 2 ? 20 : 15),
                    SizedBox(height: 5),
                    Text(
                      "Contact",
                      style: widget.index == 2
                          ? Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kBlueColor)
                          : Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: kBlueColor),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 20),
              InkWell(
                onTap: widget.pressLogout,
                child: Column(
                  children: [
                    Icon(Icons.logout_outlined,
                        color: kBlueColor, size: widget.index == 3 ? 20 : 15),
                    SizedBox(height: 5),
                    Text(
                      "Déconnexion",
                      style: widget.index == 3
                          ? Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kBlueColor)
                          : Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: kBlueColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
