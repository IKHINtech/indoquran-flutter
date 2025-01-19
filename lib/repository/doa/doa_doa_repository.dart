import 'package:indoquran/helpers/db_helper.dart';
import 'package:indoquran/models/doa_doa_model.dart';
import 'package:sqflite/sqflite.dart';

class DoaDoaRepository {
  final dbHelper = DBHelper();

  Future<int> insertDoaDoa(DoaDoa data) async {
    final db = await dbHelper.database;
    final payload = data.toJson();
    return await db.insert(
      DoaDoaFields.tableName,
      payload,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertListDoaDoa(List<DoaDoa> doaList) async {
    final db = await dbHelper.database;
    for (var doa in doaList) {
      final payload = doa.toJson();
      await db.insert(
        DoaDoaFields.tableName,
        payload,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getDoaDoa() async {
    final db = await dbHelper.database;
    return await db.query(DoaDoaFields.tableName);
  }

  Future<int> updateDoaDoa(int id, Map<String, dynamic> data) async {
    final db = await dbHelper.database;
    return await db
        .update(DoaDoaFields.tableName, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteDoaDoa(int id) async {
    final db = await dbHelper.database;
    return await db
        .delete(DoaDoaFields.tableName, where: 'id = ?', whereArgs: [id]);
  }
}
