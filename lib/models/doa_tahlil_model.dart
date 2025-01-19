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

//await db.execute('''
//  CREATE TABLE DoaTahlil (
//    id INTEGER PRIMARY KEY,
//    title TEXT,
//    arabic TEXT,
//    translation TEXT
//  )
//''');
//
//
class DoaTahlilFields {
  static const String tableName = 'doa_tahlil';
  static const String idType = 'INTEGER PRIMARY KEY';
  static const String textType = 'TEXT';
  static const String intType = 'INTEGER';
  static const String id = 'id';
  static const String title = 'title';
  static const String arabic = 'arabic';
  static const String translation = 'translation';
}
