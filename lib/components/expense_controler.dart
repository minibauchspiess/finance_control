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
            const Text('Tem certeza de que quer apagar esta fonte de gastos?'),
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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.expense.expenseName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  overflow: TextOverflow.visible),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            "${widget.expense.currentValue}/${widget.expense.initialValue}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () => _openUpdateExpenseForm(context),
            // child: Text("Gasto"),
            style: ButtonStyle(
              alignment: Alignment.center,
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            ),
            child: const Text("-\$"),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () => _openDeteleForm(context),
            style: ButtonStyle(
              alignment: Alignment.center,
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            ),
            child: const Icon(Icons.delete_outline),
          ),
        ),
      ],
    );
  }
}
