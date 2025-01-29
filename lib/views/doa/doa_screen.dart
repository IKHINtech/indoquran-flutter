import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/providers/doa_providers.dart';
import 'package:indoquran/views/doa/doa_doa.dart';
import 'package:indoquran/views/doa/doa_harian.dart';
import 'package:indoquran/views/doa/doa_tahlil.dart';
import 'package:provider/provider.dart';

class DoaScreen extends StatefulWidget {
  final ScrollController? controller;
  const DoaScreen({super.key, this.controller});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        int activeTab =
            Provider.of<DoaProvider>(context, listen: false).activeTab;

        tabController.index = activeTab;
        print(tabController.index);
        tabController.addListener(
          () {
            Provider.of<DoaProvider>(context, listen: false)
                .setActiveTab(tabController.index);
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
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
                      hintText: 'Cari doa...', // Menambahkan hint
                      hintStyle: const TextStyle(
                          color: Colors.grey), // Warna teks hint
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
          Expanded(
            child: DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: const EdgeInsets.only(top: 12, bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: const BoxConstraints(maxHeight: 38.0),
                    child: TabBar(
                      //onTap: (value) {
                      //  var provider =
                      //      Provider.of<DoaProvider>(context, listen: false);
                      //  provider.setActiveTab(value);
                      //},
                      dividerColor: Colors.transparent,
                      indicatorColor: cPrimary,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color:
                            cPrimary, // Ganti dengan warna indikator yang diinginkan
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      indicatorAnimation: TabIndicatorAnimation.elastic,
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
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        DoaHarianaScreen(controller: widget.controller),
                        DoaDoaScreen(controller: widget.controller),
                        DoaTahlilScreen(controller: widget.controller),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
