import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:indoquran/const/themes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: ClipPath(
                    clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      height: 200,
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: cPrimary,
                            width: 3,
                          ),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Demi masa, sungguh, manusia berada dalam kerugian, kecuali orang-orang yang beriman dan mengerjakan kebaikan serta saling menasihati untuk kebenaran dan saling menasihati untuk kesabaran.",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            "Qs. Al-`Asr : 13",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(alpha: 0.2), // Warna bayangan
                          spreadRadius: 2, // Penyebaran bayangan
                          blurRadius: 5, // Blur bayangan
                          offset: const Offset(1, 4), // Posisi bayangan
                        ),
                      ]),
                  height: 40,
                  width: 40,
                  child: const Icon(
                    size: 18,
                    TablerIcons.book,
                    color: cPrimary,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
