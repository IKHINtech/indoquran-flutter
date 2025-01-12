import 'package:flutter/material.dart';
import 'package:indoquran/providers/alquran_providers.dart';
import 'package:indoquran/widgets/card_surat.dart';
import 'package:indoquran/widgets/loading_surat.dart';
import 'package:provider/provider.dart';

class SuratPage extends StatefulWidget {
  final ScrollController controller;
  const SuratPage({required this.controller, super.key});

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
        padding: const EdgeInsets.all(16),
        child: provider.loading
            ? loadingSurat()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: titlePage(),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: provider.surat.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade300,
                      ),
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

  Row titlePage() {
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
