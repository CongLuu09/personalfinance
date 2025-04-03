import 'package:flutter/foundation.dart';
import 'package:personalfinance/data/models/financial_plan.dart';
import '../services/financial_plan_service.dart';

class FinancialPlanProvider with ChangeNotifier {
  final FinancialPlanService _planService = FinancialPlanService();
  List<FinancialPlan> _financialPlans = [];

  List<FinancialPlan> get financialPlans => _financialPlans;

  Future<void> loadPlans() async {
    _financialPlans = await _planService.getAllPlans();
    notifyListeners();
  }

  Future<void> addPlan(FinancialPlan plan) async {
    await _planService.savePlan(plan);
    _financialPlans.add(plan);
    notifyListeners();
  }

  Future<void> deletePlan(String id) async {
    await _planService.deletePlan(id);
    _financialPlans.removeWhere((plan) => plan.id == id);
    notifyListeners();
  }

  void addFinancialPlan(FinancialPlan plan) {
    _financialPlans.add(plan);
    notifyListeners();
  }


  Future<void> updatePlan(FinancialPlan plan) async {
    await _planService.updatePlan(plan);
    await loadPlans();
  }

  Future<FinancialPlan?> getPlanById(String id) async {
    return await _planService.getPlanById(id);
  }
}
