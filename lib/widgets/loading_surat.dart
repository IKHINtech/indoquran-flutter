import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/widgets/nomor.dart';
import 'package:shimmer/shimmer.dart';

class SuratLoading extends StatelessWidget {
  const SuratLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.red,
      highlightColor: Colors.yellow,
      child: ListTile(
        leading: Container(
          constraints: const BoxConstraints(
            minWidth: 40,
            maxWidth: 40,
            minHeight: 40,
            maxHeight: 40,
          ),
          child: const NomorWidget(
            nomor: 1,
          ),
        ),
        title: Text(
          "title",
          style: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "subtitle",
          style: GoogleFonts.quicksand(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Column(
          children: [
            Text("arti"),
            Text("jumlah ayat"),
          ],
        ),
      ),
    );
  }
}
