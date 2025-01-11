import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/views/alquran.dart';

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
    Colors.pink
  ];

  @override
  void initState() {
    currentScreen = 0;
    tabController = TabController(length: 4, vsync: this);
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
    final Color unselectedColor = colors[currentScreen].computeLuminance() < 0.5
        ? cPrimary
        : Colors.white;
    return Scaffold(
      appBar: AppBar(
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
      body: BottomBar(
        fit: StackFit.expand,
        icon: (width, height) => Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: null,
            icon: Icon(
              Icons.arrow_upward_rounded,
              color: unselectedColor,
              size: width,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(seconds: 1),
        curve: Curves.decelerate,
        showIcon: true,
        width: MediaQuery.of(context).size.width * 0.8,
        barColor: colors[currentScreen].computeLuminance() > 0.5
            ? cPrimary
            : Colors.white,
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
        body: (context, controller) => TabBarView(
          controller: tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const BouncingScrollPhysics(),
          children: colors
              .map((e) => SuratPage(
                    controller: controller,
                  ))
              .toList(),
        ),
        child: TabBar(
          indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          controller: tabController,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                  color: currentScreen == 0
                      ? colors[0]
                      : currentScreen == 1
                          ? colors[1]
                          : currentScreen == 2
                              ? colors[2]
                              : currentScreen == 3
                                  ? colors[3]
                                  : currentScreen == 4
                                      ? colors[4]
                                      : unselectedColor,
                  width: 4),
              insets: const EdgeInsets.fromLTRB(16, 0, 16, 8)),
          tabs: [
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                Icons.home,
                color: currentScreen == 0 ? colors[0] : unselectedColor,
              )),
            ),
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                Icons.add,
                color: currentScreen == 2 ? colors[2] : unselectedColor,
              )),
            ),
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                Icons.favorite,
                color: currentScreen == 3 ? colors[3] : unselectedColor,
              )),
            ),
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                Icons.settings,
                color: currentScreen == 4 ? colors[4] : unselectedColor,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
