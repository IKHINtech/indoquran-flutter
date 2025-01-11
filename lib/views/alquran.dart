import 'package:flutter/material.dart';
import 'package:indoquran/providers/alquran_providers.dart';
import 'package:indoquran/widgets/card_surat.dart';
import 'package:indoquran/widgets/loading_surat.dart';
import 'package:indoquran/widgets/nomor.dart';
import 'package:provider/provider.dart';

class SuratPage extends StatefulWidget {
  final ScrollController controller;
  const SuratPage({required this.controller, Key? key}) : super(key: key);

  @override
  State<SuratPage> createState() => _SuratPageState();
}

class _SuratPageState extends State<SuratPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {context.read<SuratProvider>().getListSurat()});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SuratProvider>(
      builder: (BuildContext context, SuratProvider provider, Widget? child) =>
          Container(
        padding: const EdgeInsets.all(10),
        child: !provider.loading
            ? loadingSurat()
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: provider.surat.length,
                      separatorBuilder: (context, index) => const Divider(),
                      controller: widget.controller,
                      itemBuilder: (BuildContext context, int index) {
                        return SuratCard(surat: provider.surat[index]);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

Widget loadingSurat() {
  return ListView.builder(
      itemCount: 10, itemBuilder: (context, index) => const SuratLoading());
}
