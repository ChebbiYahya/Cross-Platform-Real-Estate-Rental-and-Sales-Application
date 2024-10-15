import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';

class WebSideMenu extends StatefulWidget {
  const WebSideMenu({
    required this.pressLogout,
    required this.pressResevation,
    required this.pressContact,
    required this.pressAnnonce,
    required this.pressAddAnnonce,
    super.key,
  });
  final VoidCallback pressResevation,
      pressAnnonce,
      pressAddAnnonce,
      pressContact,
      pressLogout;

  @override
  State<WebSideMenu> createState() => _WebSideMenuState();
}

class _WebSideMenuState extends State<WebSideMenu> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/logo.svg",
                    width: 35, color: kBlueColor),
                SizedBox(height: 10),
                Text(
                  "Dashboard",
                  textAlign: TextAlign.center,
                  style: _size.width > 650
                      ? Theme.of(context).textTheme.headline4!.copyWith(
                            color: kBlueColor,
                          )
                      : Theme.of(context).textTheme.headline5!.copyWith(
                            color: kBlueColor,
                          ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            onTap: widget.pressResevation,
            horizontalTitleGap: 5.0,
            leading: Icon(Icons.notifications_active_outlined,
                color: kDarkBlueColor, size: 25),
            title: Text(
              "Réservations",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: kDarkBlueColor, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            onTap: widget.pressAnnonce,
            horizontalTitleGap: 5.0,
            leading: Icon(Icons.space_dashboard_outlined,
                color: kDarkBlueColor, size: 25),
            title: Text(
              "Annonces",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: kDarkBlueColor, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            onTap: widget.pressAddAnnonce,
            horizontalTitleGap: 5.0,
            leading:
                Icon(Icons.post_add_rounded, color: kDarkBlueColor, size: 25),
            title: Text(
              "Ajouter Annonces",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: kDarkBlueColor, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            onTap: widget.pressContact,
            horizontalTitleGap: 5.0,
            leading: Icon(Icons.contact_phone_outlined,
                color: kDarkBlueColor, size: 25),
            title: Text(
              "Contact",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: kDarkBlueColor, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            onTap: widget.pressLogout,
            horizontalTitleGap: 5.0,
            leading:
                Icon(Icons.logout_outlined, color: kDarkBlueColor, size: 25),
            title: Text(
              "Déconnecter",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: kDarkBlueColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
