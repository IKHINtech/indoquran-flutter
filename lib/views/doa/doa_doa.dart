import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/providers/doa_providers.dart';
import 'package:indoquran/widgets/nomor.dart';
import 'package:provider/provider.dart';

class DoaDoaScreen extends StatefulWidget {
  final ScrollController controller;
  const DoaDoaScreen({super.key, required this.controller});

  @override
  State<DoaDoaScreen> createState() => _DoaDoaaState();
}

class _DoaDoaaState extends State<DoaDoaScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {context.read<DoaProvider>().getListDoaDoa()});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DoaProvider>(
      builder: (BuildContext context, DoaProvider provider, Widget? child) =>
          ListView.separated(
        controller: widget.controller,
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.grey.shade300,
        ),
        itemCount: provider.doaDoa.length,
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
                    provider.doaDoa[index].judul,
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
            Text(provider.doaDoa[index].arab,
                textAlign: TextAlign.end,
                style: GoogleFonts.scheherazadeNew(
                  fontSize: 20,
                  height: 2.5,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 14),
            Text(
              provider.doaDoa[index].indo,
            ),
          ],
        ),
      ),
    );
  }
}
