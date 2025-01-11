import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/providers/alquran_providers.dart';
import 'package:indoquran/views/splash_screen.dart';
import 'package:indoquran/views/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SuratProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IndoQur`an',
        initialRoute: "/",
        routes: {
          "/home": (context) => const HomeScreen(),
        },
        theme: _buildTheme(Brightness.light),
        home: const SplashScreen(),
      ),
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.quicksandTextTheme(baseTheme.textTheme),
  );
}
