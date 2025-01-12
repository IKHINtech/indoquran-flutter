import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/providers/doa_providers.dart';
import 'package:indoquran/widgets/nomor.dart';
import 'package:provider/provider.dart';

class DoaHarianaScreen extends StatefulWidget {
  final ScrollController controller;
  const DoaHarianaScreen({super.key, required this.controller});

  @override
  State<DoaHarianaScreen> createState() => _DoaHarianaState();
}

class _DoaHarianaState extends State<DoaHarianaScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {context.read<DoaProvider>().getListDoaHarian()});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DoaProvider>(
      builder: (BuildContext context, DoaProvider provider, Widget? child) =>
          ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.grey.shade300,
        ),
        itemCount: provider.doaHarian.length,
        itemBuilder: (BuildContext context, int index) => Column(
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
                    provider.doaHarian[index].title,
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
            Text(provider.doaHarian[index].arabic,
                textAlign: TextAlign.end,
                style: GoogleFonts.scheherazadeNew(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 14),
            Text(
              provider.doaHarian[index].latin,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: cPrimary,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              provider.doaHarian[index].translation,
            ),
          ],
        ),
      ),
    );
  }
}
