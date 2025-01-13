// To parse this JSON data, do
//
//     final doaTahlil = doaTahlilFromJson(jsonString);

import 'dart:convert';

DoaTahlil doaTahlilFromJson(String str) => DoaTahlil.fromJson(json.decode(str));
List<DoaTahlil> doaTahlilListFromJson(String str) => List<DoaTahlil>.from(
    json.decode(str)['data'].map((x) => DoaTahlil.fromJson(x)));
String doaTahlilToJson(DoaTahlil data) => json.encode(data.toJson());

class DoaTahlil {
  final int id;
  final String title;
  final String arabic;
  final String translation;

  DoaTahlil({
    required this.id,
    required this.title,
    required this.arabic,
    required this.translation,
  });

  factory DoaTahlil.fromJson(Map<String, dynamic> json) => DoaTahlil(
        id: json["id"],
        title: json["title"],
        arabic: json["arabic"],
        translation: json["translation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "arabic": arabic,
        "translation": translation,
      };
}
