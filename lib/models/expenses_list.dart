import '../components/expense_controler.dart';
import '../utils/db_util.dart';

class ExpensesList {
  List<ExpenseController> _expenses = [];

  Future<void> loadExpenses() async {
    final dataList = await DbUtil.getData('ExpensesSources');

    _expenses = dataList
        .map(
          (item) => ExpenseController(
            item[DbUtil.expenseNameKey],
            item[DbUtil.availableValueKey],
          ),
        )
        .toList();
  }

  List<ExpenseController> get expensesList {
    return [..._expenses];
  }

  void addExpense(String expenseName, double value) {
    final newExpenseSource = ExpenseController(expenseName, value);

    _expenses.add(newExpenseSource);

    DbUtil.insert(DbUtil.tableName, {
      DbUtil.expenseNameKey: expenseName,
      DbUtil.availableValueKey: value,
    });
  }
}
