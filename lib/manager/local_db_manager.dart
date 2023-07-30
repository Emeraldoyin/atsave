import 'dart:async';

import 'package:easysave/model/atsave_user.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/model/savings_transactions.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../model/category.dart';
import '../model/expenses.dart';

///This is the class that contains functions and variables that handles services for storage in local database (isar database).
class LocalDbManager {
  ///creates isar instance
  static Isar? _isar;

  ///registering all schemas for collections of all objects
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

  ///clearing data from local db
  Future<void> clearDb() async {
    await _isar?.writeTxn(() async {
      _isar?.aTSaveUsers.clear();
      _isar?.savingsGoals.clear();
      _isar?.savingsTransactions.clear();
      _isar?.categorys.clear();
    });
  }

  ///function for adding a new [SavingsGoals] object to the isar collection
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

  ///function for adding a new [SavingsTransactions] object to the isar collection
  Future<int?> addSavingsTransactions(SavingsTransactions txn) async {
    final transactions = await _isar!.savingsTransactions.where().findAll();
    // ignore: prefer_is_empty
    int length = transactions.length != 0 ? transactions.last.id! + 1 : 1;
    txn.id = length;
    return await _isar?.writeTxn(() async {
      await _isar?.savingsTransactions.put(txn);
      return txn.id!;
    });
  }

  ///function for adding a new [Expenses] object to the isar collection
  Future saveExpenses(Expenses exp) async {
    final expenses = await _isar!.expenses.where().findAll();
    // ignore: prefer_is_empty
    int length = expenses.length != 0 ? expenses.last.id! + 1 : 1;
    exp.id = length;
    return await _isar!.writeTxn(() async {
      return await _isar!.expenses.put(exp);
    });
  }

  ///function for adding a new [ATSaveUser] object to the isar collection
  Future saveUser(ATSaveUser newUser) async {
    return await _isar!.writeTxn(() async {
      return await _isar!.aTSaveUsers.put(newUser);
    });
  }

  ///function for adding a new [ATSaveUser] object to the isar collection
  Future saveCategories(List<Category> category) async {
    return await _isar!.writeTxn(() async {
      return _isar!.categorys.putAll(category);
    });
  }

//fetching user
  Future<List<ATSaveUser>> getUser() async {
    return _isar!.writeTxn(() async {
      return _isar!.aTSaveUsers.where().findAll();
    });
  }

  ///fetching goals
  Future<List<SavingsGoals>> getSavingsGoal() async {
    return _isar!.writeTxn(() async {
      return _isar!.savingsGoals.where().findAll();
    });
  }

  ///fetching categories
  Future<List<Category>> getCategories() async {
    return _isar!.writeTxn(() async {
      return _isar!.categorys.where().findAll();
    });
  }

  ///fetchiing all transactions
  Future<List<SavingsTransactions>> getSavingsTransactions() async {
    return _isar!.writeTxn(() async {
      return _isar!.savingsTransactions.where().findAll();
    });
  }

  ///fetching all expenses
  Future<List<Expenses>> getExpenses() async {
    return _isar!.writeTxn(() async {
      return _isar!.expenses.where().findAll();
    });
  }

  ///deletes [SavingsTransactions] object by  id
  deleteTransactionById(SavingsTransactions txn) async {
    await _isar!
        .writeTxn(() async => await _isar!.savingsTransactions.delete(txn.id!));
  }

  ///deletes [Expenses] object by  id
  deleteExpenseById(Expenses exp) async {
    await _isar!.writeTxn(() async => await _isar!.expenses.delete(exp.id!));
  }

  ///deletes [SavingsGoals] object by  id
  Future deleteSavingsGoalsById(SavingsGoals goal) async {
    await _isar!
        .writeTxn(() async => await _isar!.savingsGoals.delete(goal.id!));
  }

  ///deletes all [SavingsTransactions] collections
  Future clearTxnByUserId(String uid) async {
    await _isar!.writeTxn(() async =>
        await _isar!.savingsTransactions.filter().uidEqualTo(uid).deleteAll());
  }

  ///deletes all [Expenses] and replaces
  Future updateExpenses(List<Expenses> exp) async {
    return _isar!.writeTxn(() async {
      await _isar!.expenses.clear();

      return _isar!.expenses.putAll(exp);
    });
  }

  ///deletes all [SavingsGoals] and replaces
  Future updateSavingsGoals(List<SavingsGoals> goals) async {
    return _isar!.writeTxn(() async {
      await _isar!.savingsGoals.clear();
      return _isar!.savingsGoals.putAll(goals);
    });
  }

  ///deletes all [SavingsTransactions] and replaces
  Future updateSavingsTransactions(List<SavingsTransactions> txn) async {
    return _isar!.writeTxn(() async {
      await _isar!.savingsTransactions.clear();
      return _isar!.savingsTransactions.putAll(txn);
    });
  }

  ///deletes [SavingsGoals] object by id and replaces
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
    });
  }

  ///adds new amount to current amount
  Future updateSavingsAmountById(double amount, int id) async {
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

//removes new amount from current amount
  Future updateSavingsAmountWithDeductions(double amount, int id) async {
    SavingsGoals? formerGoal;
    await _isar!.writeTxn(() async {
      formerGoal = await _isar!.savingsGoals.filter().idEqualTo(id).findFirst();
      if (formerGoal != null) {
        formerGoal!.currentAmount = formerGoal!.currentAmount - amount;
        formerGoal!.progressPercentage =
            formerGoal!.currentAmount / formerGoal!.targetAmount * 100;
      }
      await _isar!.savingsGoals.put(formerGoal!);
    });
  }
}
