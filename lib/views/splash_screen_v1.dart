import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'dart:async';

class SplashScreenV1 extends StatefulWidget {
  const SplashScreenV1({super.key});

  @override
  State<SplashScreenV1> createState() => _SplashScreenV1State();
}

class _SplashScreenV1State extends State<SplashScreenV1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double ring1PaddingValue;
  late double ring2PaddingValue;

  @override
  void initState() {
    super.initState();
// Inisialisasi controller animasi
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Inisialisasi nilai awal untuk padding
    ring1PaddingValue = 0.0;
    ring2PaddingValue = 0.0;

    // Menunggu dan menjalankan animasi dengan delay (menggantikan setTimeout)
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        ring1PaddingValue += 30.0; // Sesuaikan dengan hp(5) jika diperlukan
      });
      _animateRing1Padding();
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        ring2PaddingValue += 30.0; // Sesuaikan dengan hp(5.5) jika diperlukan
      });
      _animateRing2Padding();
    });
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  void _animateRing1Padding() {
    // Animasi untuk ring1Padding
    final Animation<double> animation =
        Tween<double>(begin: ring1PaddingValue - 5.0, end: ring1PaddingValue)
            .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    animation.addListener(() {
      setState(() {
        ring1PaddingValue = animation.value;
      });
    });
    _controller.forward(from: 0.0);
  }

  void _animateRing2Padding() {
    // Animasi untuk ring2Padding
    final Animation<double> animation =
        Tween<double>(begin: ring2PaddingValue - 5.5, end: ring2PaddingValue)
            .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    animation.addListener(() {
      setState(() {
        ring2PaddingValue = animation.value;
      });
    });
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
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
                  padding: EdgeInsets.all(ring1PaddingValue),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(210 / 1)),
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(microseconds: 500),
                    padding: EdgeInsets.all(ring2PaddingValue),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
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
              bottom: 40,
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
                          fontWeight: FontWeight.w500,
                        ),
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
