// To parse this JSON data, do
//
//     final doaDoa = doaDoaFromJson(jsonString);

import 'dart:convert';

DoaDoa doaDoaFromJson(String str) => DoaDoa.fromJson(json.decode(str));
List<DoaDoa> doaDoaListFromJson(String str) =>
    List<DoaDoa>.from(json.decode(str)["data"].map((x) => DoaDoa.fromJson(x)));
String doaDoaToJson(DoaDoa data) => json.encode(data.toJson());

class DoaDoa {
  final String arab;
  final String indo;
  final String judul;
  final String source;

  DoaDoa({
    required this.arab,
    required this.indo,
    required this.judul,
    required this.source,
  });

  factory DoaDoa.fromJson(Map<String, dynamic> json) => DoaDoa(
        arab: json["arab"],
        indo: json["indo"],
        judul: json["judul"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "indo": indo,
        "judul": judul,
        "source": source,
      };
}

//await db.execute('''
//  CREATE TABLE DoaDoa (
//    id INTEGER PRIMARY KEY AUTOINCREMENT,
//    arab TEXT,
//    indo TEXT,
//    judul TEXT,
//    source TEXT
//  )
//''');

class DoaDoaFields {
  static const String tableName = 'doa_doa';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT';
  static const String intType = 'INTEGER';
  static const String id = 'id';
  static const String arab = 'arab';
  static const String indo = 'indo';
  static const String judul = 'judul';
  static const String source = 'source';
}
