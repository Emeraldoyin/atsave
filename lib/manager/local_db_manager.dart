import 'dart:async';
import 'dart:developer';

import 'package:easysave/model/atsave_user.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/model/savings_transactions.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../model/category.dart';
import '../model/expenses.dart';

class LocalDbManager {
  static Isar? _isar;

  static openDb() async {
    _isar = await Isar.open(
      [
        ATSaveUserSchema,
        SavingsGoalsSchema,
        ExpensesSchema,
        SavingsTransactionsSchema,
        CategorySchema,
      ],
      directory: (await getApplicationSupportDirectory()).path,
    );
  }

  Future<void> clearDb() async {
    await _isar?.writeTxn(() async {
      _isar?.aTSaveUsers.clear();
      _isar?.savingsGoals.clear();
      _isar?.savingsTransactions.clear();
      _isar?.categorys.clear();
    });
  }

  Future<List<ATSaveUser>> getUser() async {
    return _isar!.writeTxn(() async {
      return _isar!.aTSaveUsers.where().findAll();
    });
  }

  // Future<int?> addSavingsGoal(SavingsGoals goal) async {
  //   final goals = await _isar!.savingsGoals.where().findAll();
  //   int len = goals.length + 1;
  //   goal.id = len;
 
  //   return await _isar?.writeTxn(() async {
  //     await _isar?.savingsGoals.put(goal);
  //     return goal.id!;
  //   });
  // }

  Future<int?> addSavingsGoal(SavingsGoals goal) async {
    final goals = await _isar!.savingsGoals.where().findAll();
    // ignore: prefer_is_empty
    int len = goals.length != 0 ? goals.last.id! + 1 : 1;
    goal.id = len;
    return await _isar?.writeTxn(() async {
      await _isar?.savingsGoals.put(goal);
      return goal.id!;
    });
  }

  // Future updateGoals(List<SavingsGoals> goals) async {
  //   return _isar!.writeTxn(() async {
  //     await _isar!.savingsGoals.clear();

  //     return _isar!.savingsGoals.putAll(goals);
  //   });
  // }

  Future<void> addSavingsTransactions(SavingsTransactions txn) async {
    await _isar?.writeTxn(() async {
      await _isar?.savingsTransactions.put(txn);
    });
  }

  Future<List<SavingsGoals>> getSavingsGoal() async {
    return _isar!.writeTxn(() async {
      return _isar!.savingsGoals.where().findAll();
    });
  }

  Future<List<Category>> getCategories() async {
    return _isar!.writeTxn(() async {
      return _isar!.categorys.where().findAll();
    });
  }

  Future<List<SavingsTransactions>> getSavingsTransactions() async {
    return _isar!.writeTxn(() async {
      return _isar!.savingsTransactions.where().findAll();
    });
  }

  Future<List<Expenses>> getExpenses() async {
    return _isar!.writeTxn(() async {
      return _isar!.expenses.where().findAll();
    });
  }

  Future updateSavingsGoalsById(SavingsGoals goal) async {
    print(goal.toString());
    SavingsGoals? formerGoal;
    await _isar!.writeTxn(() async {
      formerGoal =
          await _isar!.savingsGoals.filter().idEqualTo(goal.id).findFirst();
      if (formerGoal != null) {
        formerGoal = goal;
      }
      await _isar!.savingsGoals.put(goal);
      log(formerGoal.toString(), name: 'updated goal');
    });
  }

  Future updateSavingsAmount(double amount, int id) async {
    SavingsGoals? formerGoal;
    await _isar!.writeTxn(() async {
      formerGoal = await _isar!.savingsGoals.filter().idEqualTo(id).findFirst();
      if (formerGoal != null) {
        formerGoal!.currentAmount = formerGoal!.currentAmount + amount;
        formerGoal!.progressPercentage =
            formerGoal!.currentAmount / formerGoal!.targetAmount * 100;
      }
      await _isar!.savingsGoals.put(formerGoal!);
    
    });
  }

  Future deleteSavingsGoalsById(SavingsGoals goal) async {
  
    await _isar!
        .writeTxn(() async => await _isar!.savingsGoals.delete(goal.id!));
    //await _isar!.close();
  }

  Future clearTxnByUserId(String uid) async {
    await _isar!.savingsTransactions.filter().uidEqualTo(uid).deleteAll();
    //  await _isar!.close();
  }

  Future saveExpenses(Expenses exp) async {
    return await _isar!.writeTxn(() async {
      return await _isar!.expenses.put(exp);
    });
  }

  Future saveUser(ATSaveUser newUser) async {
    return await _isar!.writeTxn(() async {
      return await _isar!.aTSaveUsers.put(newUser);
    });
  }

  Future<void> increaseProgressValue(int goalId, double newProgV) async {
    SavingsGoals? goal =
        await _isar!.savingsGoals.filter().idEqualTo(goalId).findFirst();
    await _isar!.writeTxn(
      () async {
        goal!.progressPercentage == newProgV;
      },
    );
  }

  Future updateExpenses(List<Expenses> exp) async {
    return _isar!.writeTxn(() async {
      await _isar!.expenses.clear();

      return _isar!.expenses.putAll(exp);
    });
  }

  Future updateSavingsGoals(List<SavingsGoals> goals) async {
    return _isar!.writeTxn(() async {
      await _isar!.savingsGoals.clear();

      return _isar!.savingsGoals.putAll(goals);
    });
  }

  Future updateSavingsTransactions(List<SavingsTransactions> txn) async {
    return _isar!.writeTxn(() async {
      await _isar!.savingsTransactions.clear();

      return _isar!.savingsTransactions.putAll(txn);
    });
  }
}
