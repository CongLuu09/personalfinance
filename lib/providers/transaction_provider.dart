import 'package:flutter/foundation.dart';
import 'package:personalfinance/data/models/Transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions {
    return [..._transactions];
  }

  double get totalBalance {
    double total = 0;
    for (var transaction in _transactions) {
      total += transaction.amount;
    }
    return total;
  }

  void addTransaction(String description, double amount) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      description: description,
      amount: amount,
      date: DateTime.now(),
    );
    _transactions.add(newTransaction);
    notifyListeners();
  }

  void removeTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}
