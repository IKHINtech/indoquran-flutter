import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:indoquran/providers/alquran_providers.dart';
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
  //Color _textColor = Colors.white;
  bool isScrolled = false;
  static const kExpandedHeight = 180.0;
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<SuratProvider>().getDetailSurah(widget.id),
    );
    _scrollController = ScrollController()
      ..addListener(() {
        _scrollListener();
        setState(() {
          //_textColor = _isSliverAppBarExpanded ? Colors.white : Colors.black;
        });
      });
  }

  void _scrollListener() {
    // Ganti nilai threshold sesuai kebutuhan (misalnya, 100.0)
    if (_scrollController.offset > 90.0 && !isScrolled) {
      setState(() {
        isScrolled = true;
      });
    } else if (_scrollController.offset <= 90.0 && isScrolled) {
      setState(() {
        isScrolled = false;
      });
    }
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
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
                  provider: provider,
                  isSliverAppBarExpanded: _isSliverAppBarExpanded,
                  kExpandedHeight: kExpandedHeight,
                  isScrolled: isScrolled),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    return ListTile(
                      leading: Container(
                        margin: const EdgeInsets.all(8.0),
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        padding: const EdgeInsets.all(8),
                        width: 100,
                      ),
                      title: Text('Place ${index + 1}', textScaleFactor: 1.5),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ],
          ),
        ),
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
    required this.provider,
  }) : _isSliverAppBarExpanded = isSliverAppBarExpanded;

  final bool _isSliverAppBarExpanded;
  final double kExpandedHeight;
  final bool isScrolled;
  final SuratProvider provider; // Add this line>

  @override
  Widget build(BuildContext context) {
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
                child: AnimatedSwitcher(
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
                                    highlightColor: Colors.grey.shade100,
                                    child: placeHolder(30, 30),
                                  )
                                : SurahTempatTurunImage(
                                    tempatTurun:
                                        provider.suratDetail!.tempatTurun,
                                    height: 30,
                                    width: 30,
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            provider.loadingDetail
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
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
                                    highlightColor: Colors.grey.shade100,
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
                                    highlightColor: Colors.grey.shade100,
                                    child: placeHolder(50, 50),
                                  )
                                : SurahTempatTurunImage(
                                    tempatTurun:
                                        provider.suratDetail!.tempatTurun,
                                    height: 50,
                                    width: 50,
                                  ),
                            SizedBox(height: 4),
                            provider.loadingDetail
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
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
                                    highlightColor: Colors.grey.shade100,
                                    child: placeHolder(100, 8),
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
                        ),
                ),
              ),
              //background: Image.asset(
              //  'assets/images/newBeach.jpg',
              //  fit: BoxFit.fill,
              //),
            ),
    );
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
