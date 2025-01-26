import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/providers/alquran_providers.dart';
import 'package:indoquran/providers/doa_providers.dart';
import 'package:indoquran/providers/hadits_providers.dart';
import 'package:indoquran/views/doa/doa_screen.dart';
import 'package:indoquran/views/hadits/hadits_screen.dart';
import 'package:indoquran/views/home_screen.dart';
import 'package:indoquran/views/splash_screen_v1.dart';
import 'package:indoquran/views/surah/surah_detail.dart';
import 'package:indoquran/views/surah/surah_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => SplashScreenV1(),
    ),
    GoRoute(
        path: '/home',
        name: "home",
        builder: (_, state) {
          Map<String, String> params = state.uri.queryParameters;
          return HomeScreen(
            currentScreen: int.parse(params['currentScreen'] ?? '0'),
          );
        }),
    GoRoute(
      path: '/quran',
      name: "quran_list",
      builder: (_, __) => SuratScreen(),
      routes: [
        GoRoute(
          path: 'quran/:id',
          name: 'quran_detail',
          builder: (_, state) {
            return SurahDetailScreen(
              id: state.pathParameters['id'] ?? '1',
            );
            //return CustomTransitionPage<void>(
            //  key: state.pageKey,
            //  child: SurahDetailScreen(
            //    id: state.pathParameters['id'] ?? '1',
            //  ),
            //  barrierDismissible: true,
            //  barrierColor: Colors.black38,
            //  opaque: false,
            //  transitionDuration: const Duration(milliseconds: 500),
            //  reverseTransitionDuration: const Duration(milliseconds: 200),
            //  transitionsBuilder: (BuildContext context,
            //      Animation<double> animation,
            //      Animation<double> secondaryAnimation,
            //      Widget child) {
            //    return FadeTransition(
            //      opacity: animation,
            //      child: child,
            //    );
            //  },
            //);
            //return CustomTransitionPage<void>(
            //  key: state.pageKey,
            //  child: SurahDetailScreen(
            //    id: state.pathParameters['id'] ?? '1',
            //  ),
            //  transitionDuration: const Duration(milliseconds: 150),
            //  transitionsBuilder: (BuildContext context,
            //      Animation<double> animation,
            //      Animation<double> secondaryAnimation,
            //      Widget child) {
            //    // Change the opacity of the screen using a Curve based on the the animation's
            //    // value
            //    return FadeTransition(
            //      opacity:
            //          CurveTween(curve: Curves.easeInOut).animate(animation),
            //      child: child,
            //    );
            //  },
            //);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/hadits',
      name: "hadits_list",
      builder: (_, __) => HadistScreen(),
      routes: [
        GoRoute(
          path: 'hadits/:id',
          name: 'hadits_detail',
          builder: (_, state) => SurahDetailScreen(
            id: state.pathParameters['id'] ?? '1',
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/doa',
      name: "doa_list",
      builder: (_, __) => DoaScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SuratProvider()),
        ChangeNotifierProvider(create: (_) => DoaProvider()),
        ChangeNotifierProvider(create: (_) => HaditsProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'IndoQur`an',
        routerConfig: router,
        theme: _buildTheme(Brightness.light),
      ),
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: cPrimary,
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.quicksandTextTheme(baseTheme.textTheme),
  );
}
