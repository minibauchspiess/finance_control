import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import '../components/expense_controler.dart';

class DbUtil {
  static const String tableName = 'ExpensesSources';
  static const String expenseNameKey = 'expenseName';
  static const String availableValueKey = 'availableValue';

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    print('opening db');
    return sql.openDatabase(
      path.join(dbPath, '$tableName.db'),
      onCreate: (db, version) {
        print("Created database");
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

    List<Map> list = await db.rawQuery('SELECT * FROM $tableName');
    print("Lista de valores");
    print(list);
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

    List<Map> list = await db.rawQuery('SELECT * FROM $tableName');
    print("Atualizando valores");
    print(list);
  }

  static Future<List<ExpenseController>> loadSavedExpenses() async {
    final dataList = await DbUtil.getData(tableName);

    return dataList
        .map(
          (item) => ExpenseController(
            item[expenseNameKey],
            item[availableValueKey],
          ),
        )
        .toList();
  }
}
