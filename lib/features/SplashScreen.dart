import 'package:flutter/material.dart';
import 'package:indoquran/const/themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: cPrimary,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Center(
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
    );
  }
}
