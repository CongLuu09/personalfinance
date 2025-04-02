import 'package:flutter/material.dart';
import 'package:personalfinance/data/models/Transaction.dart';


class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    bool isIncome = transaction.amount >= 0;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isIncome ? Colors.green : Colors.red,
          child: Icon(
            isIncome ? Icons.arrow_upward : Icons.arrow_downward,
            color: Colors.white,
          ),
        ),
        title: Text(
          transaction.description,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Ngày: ${transaction.date.toLocal().toString().split(' ')[0]}',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: Text(
          '${transaction.amount.toStringAsFixed(2)} VNĐ',
          style: TextStyle(
            color: isIncome ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
