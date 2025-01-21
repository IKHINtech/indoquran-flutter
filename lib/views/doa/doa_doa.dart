import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/models/doa_doa_model.dart';
import 'package:indoquran/providers/doa_providers.dart';
import 'package:indoquran/widgets/nomor.dart';
import 'package:indoquran/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DoaDoaScreen extends StatefulWidget {
  final ScrollController? controller;
  const DoaDoaScreen({super.key, this.controller});

  @override
  State<DoaDoaScreen> createState() => _DoaDoaaState();
}

class _DoaDoaaState extends State<DoaDoaScreen> {
  @override
  void initState() {
    super.initState();
    //Future.microtask(() => {context.read<DoaProvider>().getListDoaDoaFromDB()});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DoaProvider>(
      builder: (BuildContext context, DoaProvider provider, Widget? child) =>
          provider.loadingDoaDoa
              ? const LoadingCardDoaDoa()
              : ListView.separated(
                  controller: widget.controller,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Colors.grey.shade300,
                  ),
                  itemCount: provider.doaDoa.length,
                  itemBuilder: (BuildContext context, int index) => DoaDoaCard(
                    index: index,
                    doa: provider.doaDoa[index],
                  ),
                ),
    );
  }
}

class DoaDoaCard extends StatelessWidget {
  final int index;
  final DoaDoa doa;
  const DoaDoaCard({
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
                doa.judul,
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
        Text(doa.arab,
            textAlign: TextAlign.end,
            style: GoogleFonts.scheherazadeNew(
              fontSize: 20,
              height: 2.5,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 14),
        Text(
          doa.indo,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade500,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Chip(
            visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            backgroundColor: Colors.green[100],
            label: Text(
              doa.source.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                color: cPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoadingCardDoaDoa extends StatelessWidget {
  const LoadingCardDoaDoa({
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
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.bottomRight,
                child: Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.green,
                    ),
                  ),
                  backgroundColor: Colors.green,
                  label: placeHolder(30, 4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
