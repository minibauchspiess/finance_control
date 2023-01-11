import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/container.dart';

import 'expense_controler.dart';
import '../utils/db_util.dart';
import 'package:flutter/material.dart';
import 'new_expense_form.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({super.key});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  List<ExpenseController> _expenses = [];

  Future<void> loadExpenses() async {
    final dataList = await DbUtil.getData('ExpensesSources');

    _expenses = dataList
        .map(
          (item) => ExpenseController(
            item[DbUtil.expenseNameKey],
            item[DbUtil.availableValueKey],
            _deleteExpenseController,
          ),
        )
        .toList();
  }

  _addExpenseController(String title, double value) {
    setState(() {
      final newExpenseSource =
          ExpenseController(title, value, _deleteExpenseController);
      _expenses.add(newExpenseSource);
    });

    DbUtil.insert(DbUtil.tableName, {
      DbUtil.expenseNameKey: title,
      DbUtil.availableValueKey: value,
    });
  }

  _deleteExpenseController(String title) {
    setState(() {
      _expenses.removeWhere((element) => element.expenseName == title);
    });

    DbUtil.delete(DbUtil.tableName, title);
  }

  _openFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewExpenseForm(_addExpenseController);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder(
          future: loadExpenses(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : Column(children: _expenses),
        ),
        Center(
          child: FloatingActionButton(
            onPressed: () => _openFormModal(context),
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
