import 'package:flutter/material.dart';

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF00957B) // Menggunakan warna #00957B
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

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

    // Gambar path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class NomorWidget extends StatelessWidget {
  final double boxSize;

  const NomorWidget({super.key, required this.boxSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: CustomPaint(
        painter: CustomShapePainter(),
      ),
    );
  }
}
