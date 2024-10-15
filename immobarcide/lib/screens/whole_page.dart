import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'blog/blog_screen.dart';
import 'profil/profil_screen.dart';
import 'home/home_screen.dart';

class WholePage extends StatefulWidget {
  const WholePage({super.key});

  @override
  State<WholePage> createState() => _WholePageState();
}

class _WholePageState extends State<WholePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late TabController _tabController;
  int _selectedTabIndex = 0;
  String? Category = "", Type = "", Location = "";
  bool? isHome = false;
  late Animation<double> navBarOpacity;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1700),
        reverseDuration: Duration(milliseconds: 375));

    navBarOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () {
      controller.forward();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    setState(() {
      _selectedTabIndex = _tabController.index;
    });
  }

  int indexMobile = 0;
  final itemsMobile = [
    Icon(Icons.home, size: 30),
    Icon(Icons.shopping_bag_outlined, size: 30),
    Icon(Icons.person, size: 30)
  ];

  @override
  Widget build(BuildContext context) {
    void _handleTabChangedWeb(int index) {
      setState(() {
        _selectedTabIndex = index;
        _tabController.index = index;
      });
    }

    void _handleTabChangedMobile(int indexMobile) {
      setState(() {
        this.indexMobile = indexMobile;
      });
    }

    void _filterLocation(String Location) {
      setState(() {
        this.Location = Location;
      });
    }

    void _filterType(String Type) {
      setState(() {
        this.Type = Type;
      });
    }

    void _filterCategory(String Category) {
      setState(() {
        this.Category = Category;
      });
    }

    void _filterHomeFilter(bool isHome) {
      setState(() {
        this.isHome = isHome;
      });
    }

    /* _filter(String? location, String? category, String? type) {
      setState(() {
        Category = category!;
        Type = type!;
        Location = location!;
      });
    }*/

    final screensMobile = [
      HomeScreen(
        onTabChangedWeb: _handleTabChangedWeb,
        onTabChangedMobile: _handleTabChangedMobile,
        onTabChangedFilterCategory: _filterCategory,
        onTabChangedFilterLocation: _filterLocation,
        onTabChangedFilterType: _filterType,
        onTabChangedHomeFilter: _filterHomeFilter,
      ),
      BlogScreen(
          Category: Category,
          Location: Location,
          Type: Type,
          homeSearch: isHome),
      ProfilScreen(),
    ];
    var _size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      animationDuration: Duration(milliseconds: 500),
      child: SafeArea(
        child: Scaffold(
          //extendBodyBehindAppBar: true,
          appBar:
              _size.width > 600 ? HeaderWeb(context) : HeaderMobile(context),
          bottomNavigationBar: _size.width < 600
              ? BottomBarMobile(_handleTabChangedMobile)
              : null,
          body: _size.width > 600
              ? TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HomeScreen(
                      onTabChangedWeb: _handleTabChangedWeb,
                      onTabChangedMobile: _handleTabChangedMobile,
                      onTabChangedFilterCategory: _filterCategory,
                      onTabChangedFilterLocation: _filterLocation,
                      onTabChangedFilterType: _filterType,
                      onTabChangedHomeFilter: _filterHomeFilter,
                    ),
                    BlogScreen(
                        Category: Category,
                        Location: Location,
                        Type: Type,
                        homeSearch: isHome),
                    ProfilScreen(),
                  ],
                )
              : screensMobile[indexMobile],
        ),
      ),
    );
  }

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

  AppBar HeaderWeb(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: FadeTransition(
        opacity: navBarOpacity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: _size.width > 800
                  ? EdgeInsets.only(right: 20.0)
                  : EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/logo.svg"),
                  Text("Immobarcide",
                      style: Theme.of(context).textTheme.headline4),
                ],
              ),
            ),
            Spacer(),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              tabs: [
                buildTab("Accueil", 0),
                buildTab("Annonces", 1),
                buildTab("Profile", 2),
              ],
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    );
  }

  AppBar HeaderMobile(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, // Set elevation to 0 to remove the line
      title: FadeTransition(
        opacity: navBarOpacity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/logo.svg"),
            Text("Immobarcide", style: Theme.of(context).textTheme.headline4),
          ],
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: SvgPicture.asset(
                "assets/icons/logo.svg",
                width: 40,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: TextButton(
                    onPressed: () {},
                    child: Text("Sign in",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: kBlueColor)))),
          ],*/
      ),
    );
  }

  Widget buildTab(String text, int index) => Tab(
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: _selectedTabIndex == index
                    ? FontWeight.w700
                    : FontWeight.normal,
              ),
        ),
      );
}
