// To parse this JSON data, do
//
//     final doaHarian = doaHarianFromJson(jsonString);

import 'dart:convert';

DoaHarian doaHarianFromJson(String str) => DoaHarian.fromJson(json.decode(str));
List<DoaHarian> doaHarianListFromJson(String str) =>
    List<DoaHarian>.from(json.decode(str).map((x) => DoaHarian.fromJson(x)));
String doaHarianToJson(DoaHarian data) => json.encode(data.toJson());

class DoaHarian {
  final String title;
  final String arabic;
  final String latin;
  final String translation;

  DoaHarian({
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
  });

  factory DoaHarian.fromJson(Map<String, dynamic> json) => DoaHarian(
        title: json["title"],
        arabic: json["arabic"],
        latin: json["latin"],
        translation: json["translation"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "arabic": arabic,
        "latin": latin,
        "translation": translation,
      };
}
