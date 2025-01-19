import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/helpers/db_helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double ring1PaddingValue = 30.0;
  double ring2PaddingValue = 20.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _startSplashScreen();
  }

  Future<void> _startSplashScreen() async {
    await _initializeDatabase();
    setState(() {
      _isLoading = false;
    });
    _startAnimation();
  }

  Future<void> _initializeDatabase() async {
    try {
      // Inisialisasi database
      await DBHelper.instance.database;
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed('/home');
      });
    } catch (e) {
      print("Error initializing database: $e");
    }
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        ring2PaddingValue += 30.0;
      });
      _animateRing2Padding();
    });
  }

  void _animateRing2Padding() {
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
        color: cPrimary, // Warna utama splash screen
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: _isLoading
                  ? Container(
                      height: 130,
                      width: 130,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(130 / 2),
                      ),
                      child: Image.asset(
                        'assets/images/logo_indoquran.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  : AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.all(ring1PaddingValue),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(210 / 1)),
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
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
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(130 / 2),
                          ),
                          child: Image.asset(
                            'assets/images/logo_indoquran.png',
                            fit: BoxFit.cover,
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
                          fontWeight: FontWeight.w700,
                        ),
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
                    if (_isLoading) ...[
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: LinearProgressIndicator(),
                      ),
                      Text(
                        "Loading...",
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ]
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
