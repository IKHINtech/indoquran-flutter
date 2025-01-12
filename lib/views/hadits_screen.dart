import 'package:flutter/material.dart';
import 'package:indoquran/providers/hadits_providers.dart';
import 'package:indoquran/widgets/card_hadits.dart';
import 'package:indoquran/widgets/loading_hadits.dart';
import 'package:provider/provider.dart';

class HadistScreen extends StatefulWidget {
  final ScrollController controller;
  const HadistScreen({super.key, required this.controller});

  @override
  State<HadistScreen> createState() => _HadistScreenState();
}

class _HadistScreenState extends State<HadistScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {context.read<HaditsProvider>().getListHadits()});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HaditsProvider>(
      builder: (BuildContext context, HaditsProvider provider, Widget? child) =>
          Container(
        padding: const EdgeInsets.all(16),
        child: provider.loading
            ? loadingHadits()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: titlePage(),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: provider.surat.length,
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.grey.shade300),
                      controller: widget.controller,
                      itemBuilder: (BuildContext context, int index) {
                        return HaditsCard(
                          hadits: provider.surat[index],
                          index: index + 1,
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

Row titlePage() {
  return const Row(children: [
    Expanded(
      flex: 1,
      child: Text(
        "Hadits",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ]);
}

Widget loadingHadits() {
  return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 10,
      itemBuilder: (context, index) => const HaditsLoading());
}
