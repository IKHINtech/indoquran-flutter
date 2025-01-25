import 'dart:math';

import 'package:flutter/material.dart';
import 'package:indoquran/models/surat_model.dart';

class SurahDetailScreen extends StatefulWidget {
  final Surat surah;
  const SurahDetailScreen({super.key, required this.surah});

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
    var titleContent = [
      SurahTempatTurunImage(
        tempatTurun: widget.surah.tempatTurun,
        height: 50,
        width: 50,
      ),
      Text(
        widget.surah.namaLatin,
        textScaler: TextScaler.linear(1),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Text(
        "${widget.surah.jumlahAyat} Ayat, ${widget.surah.arti}",
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade400,
        ),
      )
    ];
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            // show and hide SliverAppBar Title
            title: _isSliverAppBarExpanded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SurahTempatTurunImage(
                        tempatTurun: widget.surah.tempatTurun,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.surah.namaLatin,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${widget.surah.jumlahAyat} Ayat, ${widget.surah.arti}",
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
                                  SurahTempatTurunImage(
                                    tempatTurun: widget.surah.tempatTurun,
                                    height: 30,
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.surah.namaLatin,
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${widget.surah.jumlahAyat} Ayat, ${widget.surah.arti}",
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
                                children: titleContent,
                              ),
                      ),
                    ),
                    //background: Image.asset(
                    //  'assets/images/newBeach.jpg',
                    //  fit: BoxFit.fill,
                    //),
                  ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return ListTile(
                  leading: Container(
                    margin: const EdgeInsets.all(8.0),
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
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
