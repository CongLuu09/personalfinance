import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:personalfinance/screens/home_screen.dart';
import 'package:personalfinance/providers/transaction_provider.dart';
import 'package:personalfinance/providers/financial_plan_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => FinancialPlanProvider()),
      ],
      child: MaterialApp(
        title: 'Ứng Dụng Quản Lý Tài Chính',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
