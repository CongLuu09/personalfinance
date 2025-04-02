import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/financial_plan_provider.dart';
import 'package:personalfinance/data/models/financial_plan.dart';

class FinancialPlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lập Kế Hoạch Tài Chính'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<FinancialPlanProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            itemCount: provider.financialPlans.length,
            itemBuilder: (context, index) {
              final plan = provider.financialPlans[index];
              return ListTile(
                title: Text(plan.goalName),
                subtitle: Text('Mục tiêu: ${plan.targetAmount} VNĐ'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    provider.deletePlan(plan.id);
                  },
                ),
                onTap: () {
                  // Điều hướng chi tiết kế hoạch tài chính nếu cần
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPlanDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }


  void _showAddPlanDialog(BuildContext context) {
    final goalController = TextEditingController();
    final targetAmountController = TextEditingController();
    final allocatedBudgetController = TextEditingController();
    final deadlineController = TextEditingController();
    final categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thêm Kế Hoạch Tài Chính'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: goalController,
                decoration: const InputDecoration(labelText: 'Tên Kế Hoạch'),
              ),
              TextField(
                controller: targetAmountController,
                decoration: const InputDecoration(labelText: 'Mục Tiêu (VNĐ)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: allocatedBudgetController,
                decoration: const InputDecoration(labelText: 'Ngân Sách Phân Bổ (VNĐ)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: deadlineController,
                decoration: const InputDecoration(labelText: 'Ngày Hết Hạn'),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Thể Loại'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                final goalName = goalController.text;
                final targetAmount = double.tryParse(targetAmountController.text) ?? 0;
                final allocatedBudget = double.tryParse(allocatedBudgetController.text) ?? 0;
                final deadline = DateTime.tryParse(deadlineController.text) ?? DateTime.now();
                final category = categoryController.text;

                if (goalName.isNotEmpty && targetAmount > 0 && allocatedBudget > 0) {

                  Provider.of<FinancialPlanProvider>(context, listen: false).addFinancialPlan(
                    FinancialPlan(
                      id: DateTime.now().toString(),
                      goalName: goalName,
                      targetAmount: targetAmount,
                      allocatedBudget: allocatedBudget,
                      deadline: deadline,
                      currentProgress: 0,
                      category: category,
                    ),
                  );

                  Navigator.of(context).pop();
                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vui lòng nhập thông tin hợp lệ!')),
                  );
                }
              },
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }
}
