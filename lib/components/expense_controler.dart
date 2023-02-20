import 'package:flutter/material.dart';
import 'update_expense_form.dart';
import '../utils/expenses_data_base_handler.dart';
import '../models/expense.dart';

class ExpenseController extends StatefulWidget {
  Expense expense;
  final Function(String) deleteController;

  ExpenseController(this.expense, this.deleteController);

  @override
  State<ExpenseController> createState() => _ExpenseControllerState();
}

class _ExpenseControllerState extends State<ExpenseController> {
  _ExpenseControllerState();

  _updateCurrentValue(double changesToValue) {
    double newValue = widget.expense.currentValue - changesToValue;
    newValue = (newValue * 100).round().toDouble() / 100;
    setState(() {
      widget.expense.setCurrentValue(newValue);
    });

    ExpensesDb.updateExpense(widget.expense);
  }

  _openUpdateExpenseForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return UpdateExpenseForm(_updateCurrentValue);
      },
    );
  }

  _openDeteleForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          children: [
            Text('Tem certeza de que quer apagar esta fonte de gastos?'),
            ElevatedButton(
              child: const Text('Sim'),
              onPressed: () =>
                  widget.deleteController(widget.expense.expenseName),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.expense.expenseName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          widget.expense.currentValue.toString() +
              "/" +
              widget.expense.initialValue.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        ElevatedButton(
          onPressed: () => _openUpdateExpenseForm(context),
          child: Text("Novo gasto"),
        ),
        ElevatedButton(
          onPressed: () => _openDeteleForm(context),
          child: Icon(Icons.delete_outline),
        ),
      ],
    );
  }
}
