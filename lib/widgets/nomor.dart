import 'package:flutter/material.dart';
import 'package:indoquran/const/themes.dart';

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = cPrimary // Menggunakan warna #00957B
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Tentukan ukuran dasar dari path (misalnya ukuran 100x100)
    const baseWidth = 100.0;
    const baseHeight = 100.0;

    // Hitung faktor skala berdasarkan ukuran canvas
    double scaleX = size.width / baseWidth;
    double scaleY = size.height / baseHeight;

    // Tentukan path yang ingin digambar (dalam ukuran dasar)
    final path = Path()
      ..moveTo(100, 50)
      ..lineTo(85.11, 64.54)
      ..lineTo(85.36, 85.36)
      ..lineTo(64.54, 85.11)
      ..lineTo(50, 100)
      ..lineTo(35.46, 85.11)
      ..lineTo(14.64, 85.36)
      ..lineTo(14.89, 64.54)
      ..lineTo(0, 50)
      ..lineTo(14.89, 35.46)
      ..lineTo(14.64, 14.64)
      ..lineTo(35.46, 14.89)
      ..lineTo(50, 0)
      ..lineTo(64.54, 14.89)
      ..lineTo(85.36, 14.64)
      ..lineTo(85.11, 35.46)
      ..close(); // Menutup path agar membentuk bentuk tertutup

    // Terapkan transformasi scaling
    canvas.save();
    canvas.scale(scaleX, scaleY); // Menerapkan skala pada canvas

    // Gambar path yang sudah diskalakan
    canvas.drawPath(path, paint);
// Gambar teks di tengah canvas

    // Kembalikan canvas ke posisi semula
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class NomorWidget extends StatelessWidget {
  final int nomor;
  final String? size;

  const NomorWidget({super.key, required this.nomor, this.size});

  final double boxSize = 40;
  final double textSize = 20;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "$nomor",
              style: TextStyle(
                color: cPrimary,
                fontSize: textSize,
              ),
            ),
          ),
        ),
        SizedBox(
          width: boxSize,
          height: boxSize,
          child: CustomPaint(
            painter: CustomShapePainter(),
          ),
        )
      ],
    );
  }
}
