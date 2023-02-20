import 'package:flutter/material.dart';

class ExpenseBar extends StatelessWidget {
  final double currentValue;
  final double maxValue;

  ExpenseBar(
    this.currentValue,
    this.maxValue,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(
          child: Text(
              '${currentValue.toStringAsFixed(2)}/${maxValue.toStringAsFixed(2)}'),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 12,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                widthFactor: currentValue / maxValue,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
