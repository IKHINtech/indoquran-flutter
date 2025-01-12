import 'package:flutter/material.dart';
import 'package:indoquran/widgets/nomor.dart';
import 'package:indoquran/widgets/placeholder.dart';
import 'package:shimmer/shimmer.dart';

class HaditsLoading extends StatelessWidget {
  const HaditsLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListTile(
        leading: Container(
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 2, child: placeHolder(4, 10)),
            const Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(flex: 1, child: placeHolder(4, 10)),
            const Expanded(
              flex: 4,
              child: SizedBox(),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
