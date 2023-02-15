import '../utils/expenses_data_base_handler.dart';

class Expense {
  String _expenseName = "";
  double _initialValue = 0.0;
  double _currentValue = 0.0;

  Expense(this._expenseName, this._initialValue, this._currentValue);

  void setExpenseName(String expenseName) {
    _expenseName = expenseName;
  }

  void setInitialValue(double initialValue) {
    _initialValue = initialValue;
  }

  void setCurrentValue(double currentValue) {
    _currentValue = currentValue;
  }

  String get expenseName {
    return _expenseName;
  }

  double get initialValue {
    return _initialValue;
  }

  double get currentValue {
    return _currentValue;
  }
}
