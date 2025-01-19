import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/helpers/db_helper.dart';
import 'package:indoquran/models/doa_doa_model.dart';
import 'package:indoquran/providers/doa_providers.dart';
import 'package:indoquran/repository/doa/doa_doa_repository.dart';

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
  final ValueNotifier<String> message = ValueNotifier<String>("init");

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
    _startAnimation();
    message.value = "init database...";
    await _initializeDatabase();
    message.value = "init doa doa...";
    await Future.delayed(Duration(seconds: 20));
    await _initDoaDoa();
    message.value = "delay...";
    await Future.delayed(Duration(seconds: 20));
    setState(() {
      _isLoading = false;
    });
    //Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pushReplacementNamed('/home');
    //});
  }

  Future<void> _initDoaDoa() async {
    try {
      List<DoaDoa> doaList = await DoaProvider().getListDodDoaFromDB();
      if (doaList.isEmpty) {
        List<DoaDoa> doaListss = await DoaProvider().getListDoaDoa();
        await DoaDoaRepository().insertListDoaDoa(doaListss);
      }
    } catch (e) {
      print("Error init doa doa: $e");
    }
  }

  Future<void> _initializeDatabase() async {
    try {
      // Inisialisasi database
      await DBHelper.instance.database;
    } catch (e) {
      print("Error initializing database: $e");
    }
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        ring2PaddingValue += 30.0;
      });
      _animateRing1Padding();
    });
  }

  void _animateRing1Padding() {
    // Tween untuk mengatur rentang animasi
    final Animation<double> animation = Tween<double>(
      begin: ring2PaddingValue - 30.0, // Nilai lebih kecil
      end: ring2PaddingValue + 30.0, // Nilai lebih besar
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Animasi dengan kurva yang halus
      ),
    );

    // Listener untuk memperbarui nilai padding
    animation.addListener(() {
      setState(() {
        ring2PaddingValue = animation.value;
      });
    });

    // Mulai animasi berulang dengan arah bolak-balik
    _controller.repeat(reverse: true);
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
              child: AnimatedContainer(
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
                        padding: EdgeInsets.all(10),
                        child: LinearProgressIndicator(),
                      ),
                      ValueListenableBuilder(
                          valueListenable: message,
                          builder: (BuildContext context, String value, _) {
                            return Text(
                              value,
                              style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          })
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
