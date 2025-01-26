import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:indoquran/providers/alquran_providers.dart';
import 'package:indoquran/widgets/card_surat.dart';
import 'package:indoquran/widgets/loading_surat.dart';
import 'package:provider/provider.dart';

class SuratScreen extends StatefulWidget {
  final ScrollController? controller;
  const SuratScreen({this.controller, super.key});

  @override
  State<SuratScreen> createState() => _SuratScreenState();
}

class _SuratScreenState extends State<SuratScreen> {
  GlobalKey? _key;
  @override
  void initState() {
    super.initState();
    //Future.microtask(() => {context.read<SuratProvider>().getListSurat()});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SuratProvider>(
      builder: (BuildContext context, SuratProvider provider, Widget? child) =>
          Material(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: provider.loading
              ? loadingSurat()
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: titleScreen(),
                    ),
                    Expanded(
                      child: AnimatedList.separated(
                        key: _key,
                        removedSeparatorBuilder:
                            (BuildContext context, int index, animation) {
                          return Divider();
                        },
                        initialItemCount: provider.surat.length,
                        separatorBuilder: (context, index, animation) =>
                            Divider(
                          color: Colors.grey.shade300,
                        ),
                        controller: widget.controller,
                        itemBuilder:
                            (BuildContext context, int index, animation) {
                          return SizeTransition(
                            sizeFactor: animation,
                            child: SurahCard(
                              onTap: () {
                                context.goNamed(
                                  "quran_detail",
                                  pathParameters: {
                                    "id":
                                        provider.surat[index].nomor.toString(),
                                  },
                                );
                              },
                              surat: provider.surat[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Row titleScreen() {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Text(
            "Al-Qur'an",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 35,
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  TablerIcons.search,
                  color: Colors.grey.shade300,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 16.0,
                ),
                hintText: 'Cari surat...', // Menambahkan hint
                hintStyle:
                    const TextStyle(color: Colors.grey), // Warna teks hint
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color:
                        Colors.grey.shade400, // Warna border saat tidak fokus
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.grey, // Warna border saat fokus
                    width: 1.0, // Ketebalan border
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

Widget loadingSurat() {
  return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 10,
      itemBuilder: (context, index) => const SuratLoading());
}
