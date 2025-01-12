import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/views/doa/doa_screen.dart';
import 'package:indoquran/views/surah/surah_screen.dart';
import 'package:indoquran/views/hadits/hadits_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late int currentScreen;
  late TabController tabController;
  final List<Color> colors = [
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.pink
  ];

  @override
  void initState() {
    currentScreen = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentScreen && mounted) {
          changeScreen(value);
        }
      },
    );
    super.initState();
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
    final Color unselectedColor =
        colors[currentScreen].computeLuminance() < 0.5 ? cPrimary : Colors.grey;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
          child: Image.asset(
            "assets/images/logo_indoquran.png",
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
      ),
      body: CustomBottomBar(
          unselectedColor: unselectedColor,
          colors: colors,
          currentScreen: currentScreen,
          tabController: tabController),
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.unselectedColor,
    required this.colors,
    required this.currentScreen,
    required this.tabController,
  });

  final Color unselectedColor;
  final List<Color> colors;
  final int currentScreen;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BottomBar(
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
          SuratScreen(controller: controller),
          HadistScreen(controller: controller),
          DoaScreen(controller: controller),
          HadistScreen(controller: controller),
          HadistScreen(controller: controller),
        ];
        return TabBarView(
          controller: tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const BouncingScrollPhysics(),
          children: screens,
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: TabBar(
          dividerColor: Colors.transparent,
          indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          controller: tabController,
          indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                color: cPrimary,
                width: 4,
              ),
              insets: EdgeInsets.fromLTRB(16, 0, 16, 8)),
          tabs: const [
            SizedBox(
              height: 60,
              width: 40,
              child: Center(
                child: Icon(
                  TablerIcons.book,
                  color: cPrimary,
                ),
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
            SizedBox(
              height: 60,
              width: 40,
              child: Center(
                child: Icon(
                  TablerIcons.bookmarks,
                  color: cPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
