import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/models/doa_tahlil_model.dart';
import 'package:indoquran/providers/doa_providers.dart';
import 'package:indoquran/widgets/nomor.dart';
import 'package:indoquran/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DoaTahlilScreen extends StatefulWidget {
  final ScrollController? controller;
  const DoaTahlilScreen({super.key, this.controller});

  @override
  State<DoaTahlilScreen> createState() => _DoaTahlilaState();
}

class _DoaTahlilaState extends State<DoaTahlilScreen> {
  @override
  void initState() {
    super.initState();
    //Future.microtask(
    //    () => {context.read<DoaProvider>().getListDoaTahlilFromDB()});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DoaProvider>(
      builder: (BuildContext context, DoaProvider provider, Widget? _) {
        return provider.loadingDoaTahlil
            ? LoadingCardDoaTahlil()
            : provider.doaTahlil.isNotEmpty
                ? ListView.separated(
                    controller: widget.controller,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color: Colors.grey.shade300,
                    ),
                    itemCount: provider.doaDoa.length,
                    itemBuilder: (BuildContext context, int index) =>
                        DoaTahlilCard(
                      index: index,
                      doa: provider.doaTahlil[index],
                    ),
                  )
                : Center(
                    child: Text(
                      'No Data',
                      style: GoogleFonts.montserrat(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  );
      },
    );
  }
}

class DoaTahlilCard extends StatelessWidget {
  final int index;
  final DoaTahlil doa;
  const DoaTahlilCard({
    super.key,
    required this.index,
    required this.doa,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: NomorWidget(nomor: index + 1),
            ),
            Expanded(
              child: Text(
                doa.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
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
        ),
        const SizedBox(height: 14),
        Text(doa.arabic,
            textAlign: TextAlign.end,
            style: GoogleFonts.scheherazadeNew(
              fontSize: 20,
              height: 2.5,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 14),
        Text(
          doa.translation,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

class LoadingCardDoaTahlil extends StatelessWidget {
  const LoadingCardDoaTahlil({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: Colors.grey.shade300,
      ),
      itemBuilder: (context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
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
                  ),
                  placeHolder(80, 10),
                  const Expanded(
                    child: SizedBox(),
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
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: placeHolder(80, 10)),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: placeHolder(80, 10)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
