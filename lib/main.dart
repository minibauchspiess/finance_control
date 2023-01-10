import 'package:finance_control/components/new_expense_form.dart';
import 'package:finance_control/components/expenses_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpensesViewer());
}

class ExpensesViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ExpensesList expenseControllerList = ExpensesList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gastos mensais'),
        ),
        body: ExpensesList(),
      ),
    );
  }
}
