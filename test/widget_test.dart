import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:personalfinance/main.dart';
import 'package:personalfinance/providers/transaction_provider.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

    await tester.pumpWidget(
      ChangeNotifierProvider<TransactionProvider>(
        create: (_) => TransactionProvider(),
        child: const FinanceManagerApp(),
      ),
    );


    expect(find.text('Số dư hiện tại: 0.0'), findsOneWidget);


    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();


    expect(find.text('Số dư hiện tại: -20000.0'), findsOneWidget);
  });
}
