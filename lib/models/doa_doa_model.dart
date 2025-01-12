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
