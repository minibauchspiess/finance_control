import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/container.dart';

import 'expense_controler.dart';
import '../utils/expenses_data_base_handler.dart';
import 'package:flutter/material.dart';
import 'new_expense_form.dart';
import '../models/expense.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({super.key});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  List<ExpenseController> _expenses = [];
  bool loaded = false;

  Future<void> loadExpenses() async {
    final testeList = await ExpensesDb.getExpenseList();

    if (!loaded) {
      testeList.forEach((expense) {
        _expenses.add(ExpenseController(expense, _deleteExpenseController));
      });
      loaded = true;
    }
  }

  _addExpenseController(String title, double value) {
    Expense newExpense = Expense(title, value, value);
    setState(() {
      final newExpenseSource =
          ExpenseController(newExpense, _deleteExpenseController);
      _expenses.add(newExpenseSource);
    });

    ExpensesDb.insertExpense(newExpense);
  }

  _deleteExpenseController(String title) {
    setState(() {
      _expenses.removeWhere((element) => element.expense.expenseName == title);
    });

    ExpensesDb.deleteExpense(title);
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
                  : Container(
                      height: 580,
                      child: ListView.builder(
                          itemCount: _expenses.length,
                          itemBuilder: (ctx, index) {
                            return _expenses[index];
                          }),
                    ),
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
