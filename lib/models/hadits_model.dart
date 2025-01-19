// To parse this JSON data, do
//
//     final hadits = haditsFromJson(jsonString);

import 'dart:convert';

Hadits haditsFromJson(String str) => Hadits.fromJson(json.decode(str));

List<Hadits> haditsListFromJson(String str) =>
    List.from(json.decode(str).map((x) => Hadits.fromJson(x)));

String haditsToJson(Hadits data) => json.encode(data.toJson());

class Hadits {
  final String name;
  final String slug;
  final int total;

  Hadits({
    required this.name,
    required this.slug,
    required this.total,
  });

  factory Hadits.fromJson(Map<String, dynamic> json) => Hadits(
        name: json["name"],
        slug: json["slug"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "total": total,
      };
}

//await db.execute('''
//  CREATE TABLE Hadits (
//    id INTEGER PRIMARY KEY AUTOINCREMENT,
//    name TEXT,
//    slug TEXT,
//    total INTEGER
//  )
//''');
//

class HaditsFields {
  static const String tableName = 'hadits';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT';
  static const String intType = 'INTEGER';
  static const String id = 'id';
  static const String name = 'name';
  static const String slug = 'slug';
  static const String total = 'total';
}
