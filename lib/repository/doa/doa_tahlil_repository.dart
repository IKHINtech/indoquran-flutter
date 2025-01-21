import 'package:indoquran/helpers/db_helper.dart';
import 'package:indoquran/models/doa_tahlil_model.dart';
import 'package:sqflite/sqflite.dart';

class DoaTahlilRepository {
  final dbHelper = DBHelper();

  Future<int> insertDoaTahlil(DoaTahlil data) async {
    final db = await dbHelper.database;
    final payload = data.toJson();
    return await db.insert(
      DoaTahlilFields.tableName,
      payload,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertListDoaTahlil(List<DoaTahlil> doaList) async {
    final db = await dbHelper.database;
    for (var doa in doaList) {
      final payload = doa.toJson();
      await db.insert(
        DoaTahlilFields.tableName,
        payload,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getDoaTahlil() async {
    final db = await dbHelper.database;
    return await db.query(DoaTahlilFields.tableName);
  }

  Future<int> updateDoaTahlil(int id, Map<String, dynamic> data) async {
    final db = await dbHelper.database;
    return await db.update(DoaTahlilFields.tableName, data,
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteDoaTahlil(int id) async {
    final db = await dbHelper.database;
    return await db
        .delete(DoaTahlilFields.tableName, where: 'id = ?', whereArgs: [id]);
  }
}
