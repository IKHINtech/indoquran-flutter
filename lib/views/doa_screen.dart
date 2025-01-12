import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:indoquran/const/themes.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({super.key});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                "Doa",
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
                        color: Colors
                            .grey.shade400, // Warna border saat tidak fokus
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
        ),
        bottom: TabBar(
          indicatorWeight: double.minPositive,
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: Colors.transparent,
          unselectedLabelColor: Colors.grey,
          indicatorPadding: EdgeInsets.symmetric(vertical: 10),
          indicator: BoxDecoration(
            color: cPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          indicatorColor: Colors.transparent,
          controller: tabController,
          tabs: [
            Tab(
              text: "Doa Harian",
            ),
            Tab(
              text: "Doa-doa",
            ),
            Tab(
              text: "Doa Tahlil",
            ),
          ],
        ),
      ),
    );
  }
}
