import 'package:finance_control/components/new_expense_form.dart';
import 'package:finance_control/models/expenses_list.dart';
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

  _addExpenseController(String title, double value) {
    setState(() {
      expenseControllerList.addExpense(title, value);
    });
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gastos mensais'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: FutureBuilder(
          future: expenseControllerList.loadExpenses(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : Column(children: expenseControllerList.expensesList),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _openFormModal(context),
        ),
      ),
    );
  }
}
