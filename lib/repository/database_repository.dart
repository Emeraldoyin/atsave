import 'package:easysave/model/atsave_user.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/model/savings_transactions.dart';

import '../manager/local_db_manager.dart';
import '../manager/remote_db_manager.dart';
import '../model/category.dart';
import '../model/expenses.dart';


///this file contains a class that holds the declaration of functions
///these functions are called during any activity performed throughout the use of the application by a user
///it is a link between the database services and the state management of the application
class DatabaseRepository {
  final LocalDbManager ldbm = LocalDbManager();
  final RemoteDbManager rdbm = RemoteDbManager();

  Future<List<SavingsGoals>> fSavingGoals(String uid) async =>
      rdbm.fetchRemoteSavingsGoals(uid);

  Future<List<SavingsTransactions>> fSavingTxns(String uid) async =>
      rdbm.fetchRemoteSavingsTransactions(uid);

  Future<List<Expenses>> fExpenses(String uid) async =>
      rdbm.fetchRemoteExpenses(uid);

  Future<List<Category>> fCategories() async => rdbm.getCategories();

  Future<List<SavingsGoals>> iSavingsGoals() async =>
      await ldbm.getSavingsGoal();

  Future<List<Category>> iCategories() async => ldbm.getCategories();

  Future<List<SavingsTransactions>> iSavingsTransactions() async =>
      ldbm.getSavingsTransactions();

  Future<List<Expenses>> iExpenses() async => ldbm.getExpenses();

  deleteGoalFromLocalDB(SavingsGoals goal) async =>
      await ldbm.deleteSavingsGoalsById(goal);

  deleteGoalFromServer(SavingsGoals goal) async =>
      await rdbm.deleteSavingsGoals(goal);

  deleteTransactionFromServer(SavingsTransactions txn) async {
    await rdbm.deleteSavingsTransaction(txn);
  }

  deleteTransactionById(SavingsTransactions txn) async {
    ldbm.deleteTransactionById(txn);
  }

  clearTransactions(String uid) async => ldbm.clearTxnByUserId(uid);

  deleteExpensesById(Expenses exp) async {
    ldbm.deleteExpenseById(exp);
  }

  deleteExpensesFromServer(Expenses exp) async {
    rdbm.deleteExpenses(exp);
  }

  updateGoalsInLocalDB(List<SavingsGoals> goals) async {
    await ldbm.updateSavingsGoals(goals);
  }

  updateSavingsGoalById(SavingsGoals goal) async {
    await ldbm.updateSavingsGoalsById(goal);
  }

  updateCurrentAmount(double amount, int id) async {
    await ldbm.updateSavingsAmount(amount, id);
  }
    updateCurrentAmountWithDeduction(double amount, int id) async {
    await ldbm.updateSavingsAmountWithDeductions(amount, id);
  }

  updateSavingsGoalsInServer(List<SavingsGoals> goals, String uid) async {
    rdbm.updateSavingsGoalInServer(goals, uid);
  }

  updateExpensesInServer(List<Expenses> exp, String uid) async {
    await rdbm.updateExpensesInServer(exp, uid);
  }

  updateSavingsTransactionsInServer(
      List<SavingsTransactions> txn, String uid) async {
    rdbm.updateSavingsTransactionsInServer(txn, uid);
  }

  closeDB() async => await ldbm.clearDb();

  Future getCurrentUser(ATSaveUser user) async => await ldbm.saveUser(user);

  Future<int?> saveGoal(SavingsGoals goal) async =>
      await ldbm.addSavingsGoal(goal);

  Future<int?> saveExpenses(Expenses exp) async =>
      await ldbm.saveExpenses(exp);

  Future<int?> saveTransaction(SavingsTransactions txn) async =>
      await ldbm.addSavingsTransactions(txn);

  saveSavingsGoalsToServer(SavingsGoals goal) =>
      rdbm.saveSavingsGoalToServer(goal);

  saveSavingsTransactionsToServer(SavingsTransactions txn) =>
      rdbm.saveSavingsTransactionsToServer(txn);

  saveExpensesToServer(Expenses exp) async {
    rdbm.saveExpensesToServer(exp);
  }
}
