import 'package:flutter/material.dart';
import 'update_expense_form.dart';
import '../utils/db_util.dart';

class ExpenseController extends StatefulWidget {
  final String expenseName;
  final double initialValueAlocated;
  // final Function AddNewController;

  ExpenseController(this.expenseName, this.initialValueAlocated);

  @override
  State<ExpenseController> createState() =>
      _ExpenseControllerState(initialValueAlocated);
}

class _ExpenseControllerState extends State<ExpenseController> {
  double currentValueAvailable;

  _ExpenseControllerState(this.currentValueAvailable);

  _updateCurrentValue(double changesToValue) {
    setState(() {
      currentValueAvailable -= changesToValue;
      print(currentValueAvailable);
    });

    DbUtil.updateAvailableValue(widget.expenseName, currentValueAvailable);
  }

  _openUpdateExpenseForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return UpdateExpenseForm(_updateCurrentValue);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.expenseName),
        Text(currentValueAvailable.toString()),
        ElevatedButton(
          onPressed: () => _openUpdateExpenseForm(context),
          child: Text("Novo gasto"),
        ),
        ElevatedButton(
          onPressed: () => null,
          child: Icon(Icons.delete_outline),
        ),
      ],
    );
  }
}