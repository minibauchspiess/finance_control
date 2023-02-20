import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import '../models/expense.dart';

class ExpensesDb {
  static const String tableName = 'ExpensesSources';
  static const String expenseNameKey = 'expenseName';
  static const String initialValueKey = 'initialValue';
  static const String availableValueKey = 'availableValue';

  static Future<sql.Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();

    final db = await sql.openDatabase(
      path.join(dbPath, '$tableName.db'),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE $tableName (
                  $expenseNameKey TEXT PRIMARY KEY, 
                  $initialValueKey REAL, 
                  $availableValueKey REAL
                )
          ''',
        );
      },
      version: 1,
    );
    return db;
  }

  static Future<List<String>> get expenseNames async {
    final db = await ExpensesDb._getDatabase();
    final namesMap =
        await db.rawQuery('SELECT $expenseNameKey FROM $tableName');
    final namesList =
        namesMap.map((item) => item[expenseNameKey].toString()).toList();
    return namesList;
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await ExpensesDb._getDatabase();

    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertExpense(Expense expense) async {
    final db = await ExpensesDb._getDatabase();

    await db.rawInsert(
        'INSERT INTO $tableName($expenseNameKey, $initialValueKey, $availableValueKey) VALUES(?, ?, ?)',
        [expense.expenseName, expense.initialValue, expense.currentValue]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await ExpensesDb._getDatabase();
    return db.query(table);
  }

  static Future<List<Expense>> getExpenseList() async {
    final db = await ExpensesDb._getDatabase();
    final dbData = await db.query(tableName);

    return dbData
        .map((row) => Expense(row[expenseNameKey].toString(),
            row[initialValueKey] as double, row[availableValueKey] as double))
        .toList();
  }

  static Future<List<Map<String, dynamic>>> getSingleData(
      String expenseName) async {
    final db = await ExpensesDb._getDatabase();

    return db.rawQuery(
        'SELECT * FROM $tableName WHERE $expenseNameKey = ?', [expenseName]);
  }

  static Future<void> updateAvailableValue(
      String expenseName, double newValue) async {
    final db = await _getDatabase();
    await db.rawUpdate(
        'UPDATE $tableName SET $availableValueKey = ? WHERE $expenseNameKey = ?',
        [newValue, expenseName]);
  }

  static Future<void> updateExpense(Expense expense) async {
    final db = await _getDatabase();
    await db.rawUpdate(
        'UPDATE $tableName SET $availableValueKey = ? WHERE $expenseNameKey = ?',
        [expense.currentValue, expense.expenseName]);
  }

  static Future<void> delete(String table, String expenseName) async {
    final db = await ExpensesDb._getDatabase();

    await db.rawDelete(
        'DELETE FROM $tableName WHERE $expenseNameKey = ?', [expenseName]);
  }

  static Future<void> deleteExpense(String expenseName) async {
    final db = await ExpensesDb._getDatabase();

    await db.rawDelete(
        'DELETE FROM $tableName WHERE $expenseNameKey = ?', [expenseName]);
  }
}
