import 'package:indoquran/helpers/db_helper.dart';
import 'package:indoquran/models/hadits_model.dart';
import 'package:indoquran/models/surat_model.dart';
import 'package:sqflite/sqflite.dart';

class HaditsRepository {
  final dbHelper = DBHelper();

  Future<int> insertHadits(Hadits data) async {
    final db = await dbHelper.database;
    final payload = data.toJson();
    return await db.insert(
      HaditsFields.tableName,
      payload,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertListHadits(List<Hadits> doaList) async {
    final db = await dbHelper.database;
    for (var doa in doaList) {
      final payload = doa.toJson();
      await db.insert(
        HaditsFields.tableName,
        payload,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getHadits() async {
    final db = await dbHelper.database;
    return await db.query(HaditsFields.tableName);
  }

  Future<int> updateHadits(int id, Map<String, dynamic> data) async {
    final db = await dbHelper.database;
    return await db
        .update(HaditsFields.tableName, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteHadits(int id) async {
    final db = await dbHelper.database;
    return await db
        .delete(HaditsFields.tableName, where: 'id = ?', whereArgs: [id]);
  }
}
