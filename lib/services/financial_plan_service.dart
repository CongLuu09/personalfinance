import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:personalfinance/data/models/financial_plan.dart';

class FinancialPlanService {
  static final FinancialPlanService _instance = FinancialPlanService._internal();
  factory FinancialPlanService() => _instance;
  FinancialPlanService._internal();

  static Database? _database;

  Future<Database> get _db async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'financial_plans.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE financial_plans (
        id TEXT PRIMARY KEY,
        goal_name TEXT,
        target_amount REAL,
        allocated_budget REAL,
        deadline TEXT,
        current_progress REAL,
        category TEXT
      )
    ''');
  }

  Future<int> savePlan(FinancialPlan plan) async {
    final db = await _db;
    return await db.insert('financial_plans', plan.toMap());
  }

  Future<List<FinancialPlan>> getAllPlans() async {
    final db = await _db;
    var result = await db.query('financial_plans');
    return result.isNotEmpty
        ? result.map((e) => FinancialPlan.fromMap(e)).toList()
        : [];
  }

  Future<int> deletePlan(String id) async {
    final db = await _db;
    return await db.delete('financial_plans', where: 'id = ?', whereArgs: [id]);
  }
}
