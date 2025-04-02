import 'package:flutter/foundation.dart';
import 'package:personalfinance/data/models/financial_plan.dart';
import '../services/financial_plan_service.dart';

class FinancialPlanProvider with ChangeNotifier {
  List<FinancialPlan> _financialPlans = [];

  List<FinancialPlan> get financialPlans => _financialPlans;

  Future<void> loadPlans() async {
    _financialPlans = await FinancialPlanService().getAllPlans();
    notifyListeners();
  }

  Future<void> addPlan(FinancialPlan plan) async {
    await FinancialPlanService().savePlan(plan);
    _financialPlans.add(plan);
    notifyListeners();
  }

  Future<void> deletePlan(String id) async {
    await FinancialPlanService().deletePlan(id);
    _financialPlans.removeWhere((plan) => plan.id == id);
    notifyListeners();
  }

  void addFinancialPlan(FinancialPlan plan) {
    _financialPlans.add(plan);
    notifyListeners();
  }

}
