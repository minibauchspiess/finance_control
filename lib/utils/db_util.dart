import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import '../components/expense_controler.dart';

class DbUtil {
  static const String tableName = 'ExpensesSources';
  static const String expenseNameKey = 'expenseName';
  static const String availableValueKey = 'availableValue';

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, '$tableName.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $tableName ($expenseNameKey TEXT PRIMARY KEY, $availableValueKey REAL)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();

    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }

  static Future<void> updateAvailableValue(
      String expenseName, double newValue) async {
    final db = await database();
    await db.rawUpdate(
        'UPDATE $tableName SET $availableValueKey = ? WHERE $expenseNameKey = ?',
        [newValue, expenseName]);
  }

  static Future<void> delete(String table, String expenseName) async {
    final db = await DbUtil.database();

    await db.rawDelete(
        'DELETE FROM $tableName WHERE $expenseNameKey = ?', [expenseName]);
  }
}
