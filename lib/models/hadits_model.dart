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
        name: json[HaditsFields.name],
        slug: json[HaditsFields.slug],
        total: json[HaditsFields.total],
      );

  Map<String, dynamic> toJson() => {
        HaditsFields.name: name,
        HaditsFields.slug: slug,
        HaditsFields.total: total,
      };
}

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
