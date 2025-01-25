import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/providers/alquran_providers.dart';
import 'package:indoquran/providers/doa_providers.dart';
import 'package:indoquran/providers/hadits_providers.dart';
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
      builder: (_, __) => HomeScreen(),
    ),
    GoRoute(
      path: '/quran',
      name: "surah_list",
      builder: (_, __) => SuratScreen(),
      routes: [
        GoRoute(
          path: 'quran/:id',
          name: 'quran_detail',
          builder: (_, state) => SurahDetailScreen(
            id: state.pathParameters['id'] ?? '1',
          ),
        ),
      ],
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
