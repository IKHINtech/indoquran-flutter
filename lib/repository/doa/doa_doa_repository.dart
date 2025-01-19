import 'package:indoquran/helpers/db_helper.dart';

class DoaDoaRepository {
  final dbHelper = DBHelper();

  Future<int> insertDoaDoa(Map<String, dynamic> data) async {
    final db = await dbHelper.database;
    return await db.insert('DoaDoa', data);
  }

  Future<List<Map<String, dynamic>>> getDoaDoa() async {
    final db = await dbHelper.database;
    return await db.query('DoaDoa');
  }

  Future<int> updateDoaDoa(int id, Map<String, dynamic> data) async {
    final db = await dbHelper.database;
    return await db.update('DoaDoa', data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteDoaDoa(int id) async {
    final db = await dbHelper.database;
    return await db.delete('DoaDoa', where: 'id = ?', whereArgs: [id]);
  }
}
