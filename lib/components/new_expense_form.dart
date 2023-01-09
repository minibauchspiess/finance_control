import 'package:flutter/material.dart';

class NewExpenseForm extends StatefulWidget {
  final void Function(String, double) onSubmit;
  NewExpenseForm(this.onSubmit);
  @override
  State<NewExpenseForm> createState() => _NewExpenseFormState();
}

class _NewExpenseFormState extends State<NewExpenseForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.parse(valueController.text);
    if (title.isEmpty || value == 0) {
      return;
    }
    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              // onChanged: (newValue) => title = newValue,
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Nome da área',
              ),
            ),
            TextField(
              // onChanged: (newValue) => title = newValue,
              controller: valueController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor reservado',
              ),
            ),
            ElevatedButton(
              child: Text("Criar área de gastos"),
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }
}
