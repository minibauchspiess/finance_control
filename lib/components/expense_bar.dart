import 'package:flutter/material.dart';

class ExpenseBar extends StatelessWidget {
  late double currentValue;
  final double maxValue;
  late Color barColor;

  ExpenseBar(this.currentValue, this.maxValue) {
    if (currentValue < 0) {
      barColor = Colors.red;
      currentValue = -currentValue;
    } else {
      barColor = Colors.blue;
    }
  }

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
                widthFactor:
                    currentValue < maxValue ? currentValue / maxValue : 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: barColor,
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
