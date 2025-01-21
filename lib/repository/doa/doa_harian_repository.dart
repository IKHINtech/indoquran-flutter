import 'package:indoquran/helpers/db_helper.dart';
import 'package:indoquran/models/doa_harian_model.dart';
import 'package:sqflite/sqflite.dart';

class DoaHarianRepository {
  final dbHelper = DBHelper();

  Future<int> insertDoaHarian(DoaHarian data) async {
    final db = await dbHelper.database;
    final payload = data.toJson();
    return await db.insert(
      DoaHarianFields.tableName,
      payload,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertListDoaHarian(List<DoaHarian> doaList) async {
    final db = await dbHelper.database;
    for (var doa in doaList) {
      final payload = doa.toJson();
      await db.insert(
        DoaHarianFields.tableName,
        payload,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getDoaHarian() async {
    final db = await dbHelper.database;
    return await db.query(DoaHarianFields.tableName);
  }

  Future<int> updateDoaHarian(int id, Map<String, dynamic> data) async {
    final db = await dbHelper.database;
    return await db.update(DoaHarianFields.tableName, data,
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteDoaHarian(int id) async {
    final db = await dbHelper.database;
    return await db
        .delete(DoaHarianFields.tableName, where: 'id = ?', whereArgs: [id]);
  }
}
