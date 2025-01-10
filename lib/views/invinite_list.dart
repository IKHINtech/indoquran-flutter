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
    return Column(
      children: [
        NomorWidget(boxSize: 20),
        Expanded(
          child: ListView.builder(
            controller: controller,
            // reverse: true,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                title: Text("$index"),
              );
            },
          ),
        ),
      ],
    );
  }
}
