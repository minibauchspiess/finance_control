import 'package:flutter/material.dart';
import '../utils/expenses_data_base_handler.dart';

class UpdateExpenseForm extends StatefulWidget {
  final Function(double) onSubmit;
  const UpdateExpenseForm(this.onSubmit);

  @override
  State<UpdateExpenseForm> createState() => _UpdateExpenseFormState();
}

class _UpdateExpenseFormState extends State<UpdateExpenseForm> {
  final valueController = TextEditingController();
  _submitForm() {
    final value = double.parse(valueController.text);
    if (value == 0) {
      return;
    }
    widget.onSubmit(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: valueController,
          onSubmitted: (_) => _submitForm(),
          decoration: InputDecoration(
            labelText: 'Gasto',
          ),
        ),
        ElevatedButton(
          child: Text("New expense"),
          onPressed: _submitForm,
        ),
      ],
    );
  }
}
