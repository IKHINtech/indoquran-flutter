// To parse this JSON data, do
//
//     final doaHarian = doaHarianFromJson(jsonString);

import 'dart:convert';

DoaHarian doaHarianFromJson(String str) => DoaHarian.fromJson(json.decode(str));
List<DoaHarian> doaHarianListFromJson(String str) => List<DoaHarian>.from(
    json.decode(str)['data'].map((x) => DoaHarian.fromJson(x)));
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
        title: json[DoaHarianFields.title],
        arabic: json[DoaHarianFields.arabic],
        latin: json[DoaHarianFields.latin],
        translation: json[DoaHarianFields.translation],
      );

  Map<String, dynamic> toJson() => {
        DoaHarianFields.title: title,
        DoaHarianFields.arabic: arabic,
        DoaHarianFields.latin: latin,
        DoaHarianFields.translation: translation,
      };
}

//await db.execute('''
//  CREATE TABLE DoaHarian (
//    id INTEGER PRIMARY KEY AUTOINCREMENT,
//    title TEXT,
//    arabic TEXT,
//    latin TEXT,
//    translation TEXT
//  )
//''');
//

class DoaHarianFields {
  static const String tableName = 'doa_harian';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT';
  static const String intType = 'INTEGER';
  static const String id = 'id';
  static const String title = 'title';
  static const String arabic = 'arabic';
  static const String latin = 'latin';
  static const String translation = 'translation';
}
