import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;

    return Expanded(
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return TransactionItem(transaction: transactions[index]);
        },
      ),
    );
  }
}
