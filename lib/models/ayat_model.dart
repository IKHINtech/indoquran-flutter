List<Ayat> ayatListFromJson(List<dynamic> data) {
  return data.map((e) => Ayat.fromJson(e)).toList();
}

class Ayat {
  //final int id;
  final int? nomorSurat;
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final Map<String, String>? audio;

  Ayat({
    //required this.id,
    this.nomorSurat,
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    this.audio,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        //id: json[AyatFields.id],
        //nomorSurat: json[AyatFields.nomorSurat],
        nomorAyat: json[AyatFields.nomorAyat],
        teksArab: json[AyatFields.teksArab],
        teksLatin: json[AyatFields.teksLatin],
        teksIndonesia: json[AyatFields.teksIndonesia],
        audio: Map.from(json[AyatFields.audio]).map((k, v) => MapEntry(k, v)),
      );

  Map<String, dynamic> toJson() => {
        //AyatFields.id: id,
        AyatFields.nomorSurat: nomorSurat,
        AyatFields.nomorAyat: nomorAyat,
        AyatFields.teksArab: teksArab,
        AyatFields.teksLatin: teksLatin,
        AyatFields.teksIndonesia: teksIndonesia,
        //AyatFields.audio:
        //    Map.from(audio).map((k, v) => MapEntry(k.toString(), v)),
      };
}

//await db.execute('''
//     CREATE TABLE Ayat (
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       nomorSurat INTEGER NOT NULL,
//       nomorAyat INTEGER NOT NULL,
//       teksArab TEXT NOT NULL,
//       teksLatin TEXT NOT NULL,
//       teksIndonesia TEXT NOT NULL,
//       audio JSON NOT NULL,
//       FOREIGN KEY (nomorSurat) REFERENCES Surat(nomor)
//     )
//   ''');
//
//
class AyatFields {
  static const tableName = 'ayat';
  static const idType = 'INTEGER PRIMARY KEY';
  static const textType = 'TEXT';
  static const String intType = 'INTEGER';

  static const String id = 'id';
  static const String nomorSurat = 'nomorSurat';
  static const String nomorAyat = 'nomorAyat';
  static const String teksArab = 'teksArab';
  static const String teksLatin = 'teksLatin';
  static const String teksIndonesia = 'teksIndonesia';
  static const String audio = 'audio';
}
