// To parse this JSON data, do
//
//     final surat = suratFromJson(jsonString);

import 'dart:convert';

Surat suratFromJson(String str) => Surat.fromJson(json.decode(str));

List<Surat> suratListFromJson(String str) {
  List data = json.decode(str)['data'];
  return data.map((e) => Surat.fromJson(e)).toList();
}

String suratToJson(Surat data) => json.encode(data.toJson());

class Surat {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  //final Map<String, String> audioFull;

  Surat({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    //required this.audioFull,
  });

  factory Surat.fromJson(Map<String, dynamic> json) => Surat(
        nomor: json[SuratFields.id],
        nama: json[SuratFields.nama],
        namaLatin: json[SuratFields.namaLatin],
        jumlahAyat: json[SuratFields.jumlahAyat],
        tempatTurun: json[SuratFields.tempatTurun],
        arti: json[SuratFields.arti],
        deskripsi: json[SuratFields.deskripsi],
        //audioFull: Map.from(json[SuratFields.audioFull])
        //    .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        SuratFields.id: nomor,
        SuratFields.nama: nama,
        SuratFields.namaLatin: namaLatin,
        SuratFields.jumlahAyat: jumlahAyat,
        SuratFields.tempatTurun: tempatTurun,
        SuratFields.arti: arti,
        SuratFields.deskripsi: deskripsi,
        //SuratFields.audioFull:
        //    Map.from(audioFull).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

//await db.execute('''
//  CREATE TABLE Surat (
//    nomor INTEGER PRIMARY KEY,
//    nama TEXT,
//    namaLatin TEXT,
//    jumlahAyat INTEGER,
//    tempatTurun TEXT,
//    arti TEXT,
//    deskripsi TEXT,
//    audioFull TEXT
//  )
//''');
//
class SuratFields {
  static const tableName = 'surat';
  static const idType = 'INTEGER PRIMARY KEY';
  static const textType = 'TEXT';
  static const String intType = 'INTEGER';
  static const id = 'nomor';
  static const String nama = 'nama';
  static const String namaLatin = 'namaLatin';
  static const String jumlahAyat = 'jumlahAyat';
  static const String tempatTurun = 'tempatTurun';
  static const String arti = 'arti';
  static const String deskripsi = 'deskripsi';
  static const String audioFull = 'audioFull';
}
