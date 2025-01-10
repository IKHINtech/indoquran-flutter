import 'package:flutter/material.dart';
import 'package:indoquran/const/themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double padding1 = 40;
  double padding2 = 40;
  double padding3 = 16;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cPrimary,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: AnimatedPadding(
          padding: EdgeInsets.all(padding1), // Padding pertama
          duration: const Duration(microseconds: 500), // Durasi animasi
          curve: Curves.easeInOut, // Jenis kurva animasi
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(210 / 1)),
            ),
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(170 / 1)),
              ),
              child: Container(
                height: 130,
                width: 130,
                padding: const EdgeInsets.all(16), // Add padding.
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(130 / 2), // Set border radius.
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
    );
  }
}
