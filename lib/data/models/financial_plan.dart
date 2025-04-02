class FinancialPlan {
  String id;
  String goalName;
  double targetAmount;
  double allocatedBudget;
  DateTime deadline;
  double currentProgress;
  String category;

  FinancialPlan({
    required this.id,
    required this.goalName,
    required this.targetAmount,
    required this.allocatedBudget,
    required this.deadline,
    required this.currentProgress,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goal_name': goalName,
      'target_amount': targetAmount,
      'allocated_budget': allocatedBudget,
      'deadline': deadline.toIso8601String(),
      'current_progress': currentProgress,
      'category': category,
    };
  }

  static FinancialPlan fromMap(Map<String, dynamic> map) {
    return FinancialPlan(
      id: map['id'],
      goalName: map['goal_name'],
      targetAmount: map['target_amount'],
      allocatedBudget: map['allocated_budget'],
      deadline: DateTime.parse(map['deadline']),
      currentProgress: map['current_progress'],
      category: map['category'],
    );
  }
}
