import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  EdgeInsets _padding = const EdgeInsets.all(30);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(microseconds: 500),
      (timer) {
        setState(
          () {
            // Toggle padding antara 16 dan 40
            if (_padding == const EdgeInsets.all(30)) {
              _padding = const EdgeInsets.all(40);
            } else {
              _padding = const EdgeInsets.all(30);
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Pastikan timer dibatalkan ketika widget dihancurkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: cPrimary,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(microseconds: 500),
                  curve: Curves.easeInOut,
                  padding: _padding,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(210 / 1)),
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(microseconds: 500),
                    padding: _padding,
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(170 / 1)),
                    ),
                    child: Container(
                      height: 130,
                      width: 130,
                      padding: const EdgeInsets.all(20), // Add padding.
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            130 / 2), // Set border radius.
                      ),
                      child: Image.asset(
                        'assets/images/logo_indoquran.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom:
                  40, // Adjust this to set how far from the bottom you want the text
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "IndoQur`an",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      "Qur`an dan Terjemahan",
                      style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
