import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/models/hadits_model.dart';
import 'package:indoquran/widgets/nomor.dart';

class HaditsCard extends StatelessWidget {
  const HaditsCard({super.key, required this.hadits, required this.index});
  final Hadits hadits;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        constraints: const BoxConstraints(
          minWidth: 40,
          maxWidth: 40,
          minHeight: 40,
          maxHeight: 40,
        ),
        child: NomorWidget(
          nomor: index,
        ),
      ),
      title: Text(
        hadits.name,
        style: GoogleFonts.quicksand(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        "${hadits.total} Riwayat",
        style: GoogleFonts.quicksand(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}