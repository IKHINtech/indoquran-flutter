import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
//import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/views/doa/doa_screen.dart';
import 'package:indoquran/views/jadwal_sholat/jadwal_sholat.dart';
import 'package:indoquran/views/main_screen.dart';
import 'package:indoquran/views/surah/surah_screen.dart';
import 'package:indoquran/views/hadits/hadits_screen.dart';

class HomeScreen extends StatefulWidget {
  final int currentScreen;
  const HomeScreen({super.key, required this.currentScreen});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late int currentScreen = widget.currentScreen;
  late TabController tabController;
  bool isExpanded = true;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    tabController.animateTo(currentScreen);
    tabController.animation!.addListener(() {
      final value = tabController.animation!.value.round();
      if (value != currentScreen && mounted) {
        changeScreen(value);
      }
    });
    super.initState();
  }

  void changeExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void changeScreen(int newScreen) {
    setState(() {
      currentScreen = newScreen;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (currentScreen) {
      case 0:
        page = MainScreen();
        break;
      case 1:
        page = HadistScreen();
        break;
      case 2:
        page = SuratScreen();
      case 3:
        page = DoaScreen();
      case 4:
        page = JadwalSholatScreen();
      default:
        throw UnimplementedError('no widget for $currentScreen');
    }

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
          child: InkWell(
            onTap: () {
              changeExpanded();
            },
            child: Image.asset(
              "assets/images/logo_indoquran.png",
            ),
          ),
        ),
        title: Text(
          "IndoQur`an",
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: cPrimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              TablerIcons.settings,
              color: cPrimary,
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (
          BuildContext context,
          BoxConstraints constraints,
        ) {
          if (constraints.maxWidth < 450) {
            return CustomBottomBar(
              currentScreen: currentScreen,
              tabController: tabController,
              changeScreen: changeScreen,
            );
          } else {
            return landscape(constraints, page);
          }
        },
      ),
    );
  }

  Row landscape(BoxConstraints constraints, Widget page) {
    return Row(
      children: [
        SafeArea(
          child: NavigationRail(
            extended: isExpanded, // constraints.maxWidth >= 600,
            destinations: [
              NavigationRailDestination(
                icon: Icon(
                  TablerIcons.home_2,
                  color: cPrimary,
                ),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  TablerIcons.book_2,
                  color: cPrimary,
                ),
                label: Text('Hadits'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  TablerIcons.book,
                  color: cPrimary,
                ),
                label: Text('Al-Qur`an'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  TablerIcons.pray,
                  color: cPrimary,
                ),
                label: Text('Do`a'),
              ),
              NavigationRailDestination(
                icon: Icon(
                  TablerIcons.clock_hour_5,
                  color: cPrimary,
                ),
                label: Text('Jadwal Sholat'),
              ),
            ],
            selectedIndex: currentScreen,
            onDestinationSelected: (value) {
              changeScreen(value);
            },
          ),
        ),
        Expanded(child: page)
      ],
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar(
      {super.key,
      required this.currentScreen,
      required this.tabController,
      required this.changeScreen});

  final int currentScreen;
  final TabController tabController;
  final void Function(int newScreen) changeScreen;

  @override
  Widget build(BuildContext context) {
    return BottomBar(
      clip: Clip.none,
      fit: StackFit.expand,
      icon: (width, height) => Center(
        child: Card(
          elevation: 4,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: null,
            icon: Icon(
              Icons.arrow_upward_rounded,
              color: cPrimary,
              size: width,
            ),
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(20),
      duration: const Duration(seconds: 1),
      curve: Curves.decelerate,
      showIcon: true,
      width: MediaQuery.of(context).size.width * 0.9,
      barColor: Colors.white,
      start: 2,
      end: 0,
      offset: 10,
      barAlignment: Alignment.bottomCenter,
      iconHeight: 35,
      iconWidth: 35,
      reverse: false,
      hideOnScroll: true,
      scrollOpposite: false,
      onBottomBarHidden: () {},
      onBottomBarShown: () {},
      body: (context, controller) {
        var screens = [
          const MainScreen(),
          HadistScreen(controller: controller),
          SuratScreen(controller: controller),
          DoaScreen(controller: controller),
          const JadwalSholatScreen(),
        ];
        return TabBarView(
          controller: tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const BouncingScrollPhysics(),
          children: screens,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Card(
            color: Colors.white,
            elevation: 3,
            child: TabBar(
              dividerColor: Colors.transparent,
              indicatorPadding: const EdgeInsets.fromLTRB(
                6,
                0,
                6,
                0,
              ),
              controller: tabController,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: cPrimary,
                  width: 4,
                ),
                insets: EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  8,
                ),
              ),
              tabs: [
                SizedBox(
                  height: 60,
                  width: 40,
                  child: Center(
                    child: Icon(
                      TablerIcons.home,
                      color: cPrimary,
                    ),

                    //ClipRRect(
                    //  child: Image.asset(
                    //    "assets/images/icon.png",
                    //  ),
                    //),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 40,
                  child: Center(
                    child: Icon(
                      TablerIcons.book_2,
                      color: cPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 40,
                  child: Visibility(
                    visible: false,
                    child: Center(
                      child: Icon(
                        TablerIcons.pray,
                        color: cPrimary,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 40,
                  child: Center(
                    child: Icon(
                      TablerIcons.pray,
                      color: cPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 40,
                  child: Center(
                    child: Icon(
                      TablerIcons.clock_hour_5,
                      color: cPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -10,
            child: FloatingActionButton(
              elevation: 0,
              shape: CircleBorder(
                side: BorderSide(
                  color: cPrimary,
                ),
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                changeScreen(2);
                tabController.animateTo(2);
              },
              child: Icon(
                TablerIcons.book,
                color: cPrimary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
