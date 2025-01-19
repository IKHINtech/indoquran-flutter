class Ayat {
  final int id;
  final int nomorSurat;
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;
  final Map<int, String> audio;

  Ayat({
    required this.id,
    required this.nomorSurat,
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        id: json['id'],
        nomorSurat: json['nomorSurat'],
        nomorAyat: json['nomorAyat'],
        teksArab: json['teksArab'],
        teksLatin: json['teksLatin'],
        teksIndonesia: json['teksIndonesia'],
        audio: Map.from(json['audio']).map((k, v) => MapEntry(int.parse(k), v)),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nomorSurat': nomorSurat,
        'nomorAyat': nomorAyat,
        'teksArab': teksArab,
        'teksLatin': teksLatin,
        'teksIndonesia': teksIndonesia,
        'audio': Map.from(audio).map((k, v) => MapEntry(k.toString(), v)),
      };
}
