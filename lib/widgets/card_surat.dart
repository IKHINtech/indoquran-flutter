import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/widgets/nomor.dart';
import 'package:indoquran/models/surat_model.dart';

class SuratCard extends StatelessWidget {
  const SuratCard({super.key, required this.surat});
  final Surat surat;

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
        child: const NomorWidget(
          nomor: 1,
        ),
      ),
      title: Text(
        surat.namaLatin,
        style: GoogleFonts.quicksand(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        surat.arti,
        style: GoogleFonts.quicksand(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Column(
        children: [
          Text(surat.nama),
          Text("${surat.jumlahAyat.toString()} Ayat"),
        ],
      ),
    );
  }
}
