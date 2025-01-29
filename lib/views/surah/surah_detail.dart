import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoquran/const/themes.dart';
import 'package:indoquran/models/ayat_model.dart';
import 'package:indoquran/providers/alquran_providers.dart';
import 'package:indoquran/widgets/loading_ayat.dart';
import 'package:indoquran/widgets/nomor.dart';
import 'package:indoquran/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SurahDetailScreen extends StatefulWidget {
  final String? id;
  const SurahDetailScreen({super.key, this.id});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  late ScrollController _scrollController;
  final TextEditingController ayatController = TextEditingController();
  ValueNotifier<bool> isScrolled = ValueNotifier<bool>(false);
  static const kExpandedHeight = 200.0;
  ValueNotifier<bool> _isFabVisible = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<SuratProvider>().getDetailSurah(widget.id),
    );
    _scrollController = ScrollController()
      ..addListener(() {
        _scrollListener();
        setState(() {});
      });
  }

  void _scrollListener() {
    // Ganti nilai threshold sesuai kebutuhan (misalnya, 100.0)
    if (_scrollController.offset > 90.0 && !isScrolled.value) {
      isScrolled.value = true;
    } else if (_scrollController.offset <= 90.0 && isScrolled.value) {
      isScrolled.value = false;
    }

// Mengontrol visibilitas FAB berdasarkan posisi scroll
    if (_scrollController.offset > 0.0 && !_isFabVisible.value) {
      _isFabVisible.value = true; // Tampilkan FAB jika sudah tidak di atas
    } else if (_scrollController.offset <= 0.0 && _isFabVisible.value) {
      _isFabVisible.value = false; // Sembunyikan FAB jika di posisi atas
    }
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0, // Posisi paling atas
      duration: Duration(milliseconds: 500), // Durasi animasi
      curve: Curves.easeInOut, // Kurva animasi
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didpop, _) async {
        context.goNamed("home", queryParameters: {"currentScreen": "2"});
      },
      child: Scaffold(
        body: Consumer<SuratProvider>(
          builder:
              (BuildContext context, SuratProvider provider, Widget? child) =>
                  CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              CustomSliverAppBar(
                ayatController: ayatController,
                id: int.parse(widget.id!),
                isSliverAppBarExpanded: _isSliverAppBarExpanded,
                kExpandedHeight: kExpandedHeight,
                isScrolled: isScrolled,
              ),
              AyatBuilder(provider: provider),
            ],
          ),
        ),
        floatingActionButton: ValueListenableBuilder(
            valueListenable: _isFabVisible,
            builder: (context, isVisible, _) {
              return AnimatedOpacity(
                opacity: isVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: isVisible
                    ? FloatingActionButton(
                        onPressed:
                            _scrollToTop, // Scroll ke atas saat FAB ditekan
                        child: Icon(
                          Icons.arrow_upward,
                        ),
                      )
                    : null,
              );
            }),
      ),
    );
  }
}

class AyatBuilder extends StatefulWidget {
  final SuratProvider provider;
  const AyatBuilder({
    super.key,
    required this.provider,
  });

  @override
  State<AyatBuilder> createState() => _AyatBuilderState();
}

class _AyatBuilderState extends State<AyatBuilder> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (widget.provider.loadingDetail) {
            return AyatLoading();
          } else {
            Ayat ayat = widget.provider.suratDetail!.ayat![index];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          maxWidth: 40,
                          minHeight: 40,
                          maxHeight: 40,
                        ),
                        child: NomorWidget(
                          nomor: ayat.nomorAyat,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "Lihat Ayat ${ayat.nomorAyat}",
                                    style: GoogleFonts.scheherazadeNew(),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              size: 16,
                              TablerIcons.notes,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              size: 16,
                              TablerIcons.player_play,
                              color: Colors.orange,
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
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    ayat.teksArab,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.scheherazadeNew(
                      fontSize: 20,
                      height: 2.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ayat.teksLatin,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                height: 1.5,
                                color: cPrimary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              ayat.teksIndonesia,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                ],
              ),
            );
          }
        },
        childCount: widget.provider.loadingDetail
            ? 10
            : widget.provider.suratDetail != null
                ? widget.provider.suratDetail!.jumlahAyat
                : 0,
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required bool isSliverAppBarExpanded,
    required this.kExpandedHeight,
    required this.isScrolled,
    required this.id,
    required this.ayatController,
  }) : _isSliverAppBarExpanded = isSliverAppBarExpanded;
  final int id;
  final bool _isSliverAppBarExpanded;
  final double kExpandedHeight;
  final ValueNotifier<bool> isScrolled;
  final TextEditingController ayatController;

  @override
  Widget build(BuildContext context) {
    return Consumer<SuratProvider>(builder: (context, provider, _) {
      return SliverAppBar(
        // show and hide SliverAppBar Title
        title: _isSliverAppBarExpanded
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  provider.loadingDetail
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: placeHolder(20, 20),
                        )
                      : SurahTempatTurunImage(
                          tempatTurun: provider.suratDetail!.tempatTurun,
                          height: 20,
                          width: 20,
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  provider.loadingDetail
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: placeHolder(20, 10),
                        )
                      : Text(
                          provider.suratDetail!.namaLatin,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  provider.loadingDetail
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: placeHolder(30, 10),
                        )
                      : Text(
                          "${provider.suratDetail!.jumlahAyat} Ayat, ${provider.suratDetail!.arti}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade400,
                          ),
                        )
                ],
              )
            : null,
        pinned: true,
        snap: false,
        floating: false,
        expandedHeight: kExpandedHeight,
        // show and hide FlexibleSpaceBar title
        flexibleSpace: _isSliverAppBarExpanded
            ? null
            : FlexibleSpaceBar(
                centerTitle: true,
                title: Center(
                  child: ValueListenableBuilder(
                      valueListenable: isScrolled,
                      builder: (context, isScrolled, _) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: isScrolled
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                    ),
                                    provider.loadingDetail
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: placeHolder(30, 30),
                                          )
                                        : SurahTempatTurunImage(
                                            tempatTurun: provider
                                                .suratDetail!.tempatTurun,
                                            height: 30,
                                            width: 30,
                                          ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    provider.loadingDetail
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: placeHolder(40, 10),
                                          )
                                        : Text(
                                            provider.suratDetail!.namaLatin,
                                            textScaler: TextScaler.linear(1),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    provider.loadingDetail
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: placeHolder(50, 10),
                                          )
                                        : Text(
                                            "${provider.suratDetail!.jumlahAyat} Ayat, ${provider.suratDetail!.arti}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade400,
                                            ),
                                          )
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    provider.loadingDetail
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: CircleAvatar(),
                                          )
                                        : SurahTempatTurunImage(
                                            tempatTurun: provider
                                                .suratDetail!.tempatTurun,
                                            height: 50,
                                            width: 50,
                                          ),
                                    SizedBox(height: 4),
                                    provider.loadingDetail
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: placeHolder(60, 10),
                                          )
                                        : Text(
                                            provider.suratDetail!.namaLatin,
                                            textScaler: TextScaler.linear(1),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    provider.loadingDetail
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: placeHolder(100, 8),
                                          )
                                        : Text(
                                            "${provider.suratDetail!.jumlahAyat} Ayat, ${provider.suratDetail!.arti}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                    if (id != 1 && id != 9) ...[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      provider.loadingDetail
                                          ? Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                                  Colors.grey.shade100,
                                              child: placeHolder(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  14),
                                            )
                                          : Image.asset(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              "assets/images/bismillah.png",
                                            ),
                                    ],
                                    //Row(
                                    //  children: [
                                    //    Expanded(
                                    //      child: DropdownMenu<Ayat>(
                                    //        trailingIcon: Icon(Icons.api),
                                    //        controller: ayatController,
                                    //        requestFocusOnTap: false,
                                    //        onSelected: (Ayat? ayat) {
                                    //          provider.setSelectedAyat(ayat);
                                    //        },
                                    //        inputDecorationTheme:
                                    //            InputDecorationTheme(
                                    //          isDense: true,
                                    //          //contentPadding:
                                    //          //    const EdgeInsets.symmetric(
                                    //          //        horizontal: 2),
                                    //          //constraints: BoxConstraints.tight(
                                    //          //  const Size.fromHeight(30),
                                    //          //),
                                    //          border: OutlineInputBorder(
                                    //            borderRadius:
                                    //                BorderRadius.circular(8),
                                    //          ),
                                    //        ),
                                    //        dropdownMenuEntries: provider
                                    //            .suratDetail!.ayat!
                                    //            .map<DropdownMenuEntry<Ayat>>(
                                    //                (Ayat ayat) {
                                    //          return DropdownMenuEntry<Ayat>(
                                    //            value: ayat,
                                    //            label: "Buka Ayat ${ayat.nomorAyat}",
                                    //            //enabled: color.label != 'Grey',
                                    //            //style: MenuItemButton.styleFrom(
                                    //            //  foregroundColor: color.color,
                                    //            //),
                                    //          );
                                    //        }).toList(),
                                    //      ),
                                    //    ),
                                    //    Expanded(
                                    //      child: DropdownMenu<Ayat>(
                                    //        trailingIcon: Icon(Icons.api),
                                    //        controller: ayatController,
                                    //        requestFocusOnTap: false,
                                    //        onSelected: (Ayat? ayat) {
                                    //          provider.setSelectedAyat(ayat);
                                    //        },
                                    //        //inputDecorationTheme: InputDecorationTheme(
                                    //        //  isDense: true,
                                    //        //  contentPadding:
                                    //        //      const EdgeInsets.symmetric(
                                    //        //          horizontal: 2),
                                    //        //  constraints: BoxConstraints.tight(
                                    //        //    const Size.fromHeight(30),
                                    //        //  ),
                                    //        //  border: OutlineInputBorder(
                                    //        //    borderRadius: BorderRadius.circular(8),
                                    //        //  ),
                                    //        //),
                                    //        dropdownMenuEntries: provider
                                    //            .suratDetail!.ayat!
                                    //            .map<DropdownMenuEntry<Ayat>>(
                                    //                (Ayat ayat) {
                                    //          return DropdownMenuEntry<Ayat>(
                                    //            value: ayat,
                                    //            label: "Buka Ayat ${ayat.nomorAyat}",
                                    //            //enabled: color.label != 'Grey',
                                    //            //style: MenuItemButton.styleFrom(
                                    //            //  foregroundColor: color.color,
                                    //            //),
                                    //          );
                                    //        }).toList(),
                                    //      ),
                                    //    ),
                                    //  ],
                                    //),
                                  ],
                                ),
                        );
                      }),
                ),
                //background: Image.asset(
                //  'assets/images/newBeach.jpg',
                //  fit: BoxFit.fill,
                //),
              ),
      );
    });
  }
}

class SurahTempatTurunImage extends StatelessWidget {
  const SurahTempatTurunImage({
    super.key,
    required this.tempatTurun,
    this.height = 20,
    this.width = 20,
  });

  final String tempatTurun;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      tempatTurun == "Mekah"
          ? "assets/images/mekah_icon.png"
          : "assets/images/madinah_icon.png",
      height: height,
      width: width,
      fit: BoxFit.fill,
    );
  }
}
