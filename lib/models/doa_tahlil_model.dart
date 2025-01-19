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
        id: json[DoaTahlilFields.id],
        title: json[DoaTahlilFields.title],
        arabic: json[DoaTahlilFields.arabic],
        translation: json[DoaTahlilFields.translation],
      );

  Map<String, dynamic> toJson() => {
        DoaTahlilFields.id: id,
        DoaTahlilFields.title: title,
        DoaTahlilFields.arabic: arabic,
        DoaTahlilFields.translation: translation,
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
