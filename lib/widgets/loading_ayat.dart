import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/widgets/nomor.dart';
import 'package:indoquran/widgets/placeholder.dart';
import 'package:shimmer/shimmer.dart';

class AyatLoading extends StatelessWidget {
  const AyatLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    maxWidth: 40,
                    minHeight: 40,
                    maxHeight: 40,
                  ),
                  child: CustomPaint(
                    painter: CustomShapePainter(),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        size: 16,
                        TablerIcons.bookmark,
                        color: cPrimary,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        size: 16,
                        TablerIcons.dots,
                        color: cPrimary,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(flex: 2, child: placeHolder(4, 15)),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(flex: 1, child: placeHolder(4, 10)),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(flex: 1, child: placeHolder(4, 10)),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
          ],
        ),
      ),
    );
  }
}
