import 'dart:async';
import 'package:indoquran/models/doa_doa_model.dart';
import 'package:indoquran/models/doa_harian_model.dart';
import 'package:indoquran/models/doa_tahlil_model.dart';
import 'package:indoquran/models/hadits_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() => _instance;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'indo_quran.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  ${DoaDoaFields.tableName}(
        ${DoaDoaFields.id} ${DoaDoaFields.idType},
        ${DoaDoaFields.arab} ${DoaDoaFields.textType},
        ${DoaDoaFields.indo} ${DoaDoaFields.textType},
        ${DoaDoaFields.judul} ${DoaDoaFields.textType},
        ${DoaDoaFields.source} ${DoaDoaFields.textType} 
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DoaHarianFields.tableName} (
        ${DoaHarianFields.id} ${DoaHarianFields.idType},
        ${DoaHarianFields.title} ${DoaHarianFields.textType},
        ${DoaHarianFields.arabic} ${DoaHarianFields.textType},
        ${DoaHarianFields.latin} ${DoaHarianFields.textType},
        ${DoaHarianFields.translation} ${DoaHarianFields.textType}
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DoaTahlilFields.tableName} (
        ${DoaTahlilFields.id} ${DoaTahlilFields.idType},
        ${DoaTahlilFields.title} ${DoaTahlilFields.textType},
        ${DoaTahlilFields.arabic} ${DoaTahlilFields.textType},
        ${DoaTahlilFields.translation} ${DoaTahlilFields.textType}
      )
    ''');

    await db.execute('''
      CREATE TABLE ${HaditsFields.tableName} (
        ${HaditsFields.id} ${HaditsFields.idType},
        ${HaditsFields.name} ${HaditsFields.textType},
        ${HaditsFields.slug} ${HaditsFields.textType},
        ${HaditsFields.total} ${HaditsFields.intType}
      )
    ''');

    await db.execute('''
      CREATE TABLE Surat (
        nomor INTEGER PRIMARY KEY,
        nama TEXT,
        namaLatin TEXT,
        jumlahAyat INTEGER,
        tempatTurun TEXT,
        arti TEXT,
        deskripsi TEXT,
        audioFull TEXT
      )
    ''');
  }
}
