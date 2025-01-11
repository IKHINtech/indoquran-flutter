import 'package:flutter/material.dart';
import 'package:indoquran/widgets/nomor.dart';

class InfiniteListPage extends StatelessWidget {
  final Color color;
  final ScrollController controller;
  const InfiniteListPage(
      {required this.color, required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 2,
      separatorBuilder: (context, index) => const Divider(),
      controller: controller,
      // reverse: true,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {},
          leading: Container(
              constraints: const BoxConstraints(maxHeight: 40, maxWidth: 40),
              child: NomorWidget(nomor: index)),
          title: Text("Surat $index"),
          subtitle: Text("subtitle"),
          trailing: Column(
            children: [Text("trailing"), Text("data")],
          ),
        );
      },
    );
  }
}
