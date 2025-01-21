import 'package:indoquran/helpers/db_helper.dart';
import 'package:indoquran/models/surat_model.dart';
import 'package:sqflite/sqflite.dart';

class SuratRepository {
  final dbHelper = DBHelper();

  Future<int> insertSurat(Surat data) async {
    final db = await dbHelper.database;
    final payload = data.toJson();
    return await db.insert(
      SuratFields.tableName,
      payload,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertListSurat(List<Surat> doaList) async {
    final db = await dbHelper.database;
    for (var doa in doaList) {
      final payload = doa.toJson();
      await db.insert(
        SuratFields.tableName,
        payload,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getSurat() async {
    final db = await dbHelper.database;
    return await db.query(SuratFields.tableName);
  }

  Future<int> updateSurat(int id, Map<String, dynamic> data) async {
    final db = await dbHelper.database;
    return await db
        .update(SuratFields.tableName, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteSurat(int id) async {
    final db = await dbHelper.database;
    return await db
        .delete(SuratFields.tableName, where: 'id = ?', whereArgs: [id]);
  }
}
