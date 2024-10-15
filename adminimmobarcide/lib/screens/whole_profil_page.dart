import 'package:adminimmobarcide/screens/add_annonce/add_annonce_section.dart';
import 'package:adminimmobarcide/screens/annonce/annonce_section.dart';
import 'package:adminimmobarcide/screens/login/signIn.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'contact/contact_section.dart';
import 'reservation/reservation_section.dart';
import 'widget/side_menu.dart';

class WholeProfilPage extends StatefulWidget {
  const WholeProfilPage({super.key});

  @override
  State<WholeProfilPage> createState() => _WholeProfilPageState();
}

class _WholeProfilPageState extends State<WholeProfilPage> {
  int indexWeb = 0;
  void _pressReservation() {
    setState(() {
      indexWeb = 0;
    });
  }

  void _pressAnnonce() {
    setState(() {
      indexWeb = 1;
    });
  }

  void _pressAddAnnonce() {
    setState(() {
      indexWeb = 2;
    });
  }

  void _pressContact() {
    setState(() {
      indexWeb = 3;
    });
  }

  void _pressLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  int indexMobile = 0;
  final itemsMobile = [
    Icon(Icons.notifications_active_outlined, size: 25),
    Icon(Icons.space_dashboard_outlined, size: 25),
    Icon(Icons.post_add_rounded, size: 25),
    Icon(Icons.contact_phone_outlined, size: 25),
  ];
  final screensMobile = [
    ReservationSection(),
    AnnonceSection(),
    AddAnnonceSection(),
    ContactSection(),
  ];

  @override
  Widget build(BuildContext context) {
    void _handleTabChangedMobile(int indexMobile) {
      setState(() {
        this.indexMobile = indexMobile;
      });
    }

    var _size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 5,
      animationDuration: Duration(milliseconds: 500),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: _size.width < 850 ? 1 : 0,
          leading: _size.width < 850
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/logo.svg",
                      width: 35,
                    ),
                  ],
                )
              : null,
          title: _size.width > 850
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/logo.svg",
                      width: 35,
                    ),
                    Text("Immobarcide",
                        style: Theme.of(context).textTheme.headline4),
                  ],
                )
              : Center(
                  child: Text("Immobarcide",
                      style: Theme.of(context).textTheme.headline4),
                ),
          actions: [
            if (_size.width < 850)
              IconButton(
                  icon: Icon(Icons.logout_outlined), onPressed: _pressLogout)
          ],
        ),
        bottomNavigationBar:
            _size.width < 850 ? BottomBarMobile(_handleTabChangedMobile) : null,
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: SingleChildScrollView(
            child: _size.width > 850
                ? WebProfil(_size)
                : screensMobile[indexMobile],
          ),
        ),
      ),
    );
  }

  //Web Profile
  Container WebProfil(Size _size) {
    return Container(
      height: _size.height,
      child: Row(
        children: [
          Expanded(
            child: WebSideMenu(
                pressResevation: _pressReservation,
                pressContact: _pressContact,
                pressAddAnnonce: _pressAddAnnonce,
                pressAnnonce: _pressAnnonce,
                pressLogout: _pressLogout),
          ),
          Expanded(
            //it take 5/6 part of the screen
            flex: 4,
            child: Column(
              children: [
                if (indexWeb == 0)
                  Expanded(
                    child: ReservationSection(),
                  ),
                if (indexWeb == 1)
                  Expanded(
                    child: AnnonceSection(),
                  ),
                if (indexWeb == 2)
                  Expanded(
                    child: AddAnnonceSection(),
                  ),
                if (indexWeb == 3)
                  Expanded(
                    child: ContactSection(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Mobile profile

  CurvedNavigationBar BottomBarMobile(
      void _handleTabChangedMobile(int indexMobile)) {
    return CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.grey.shade200,
        items: itemsMobile,
        index: indexMobile,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        height: 50,
        onTap: (indexMobile) => _handleTabChangedMobile(indexMobile));
  }
}
