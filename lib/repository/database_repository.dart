import 'package:easysave/model/atsave_user.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/model/savings_transactions.dart';

import '../manager/local_db_manager.dart';
import '../manager/remote_db_manager.dart';
import '../model/category.dart';
import '../model/expenses.dart';

class DatabaseRepository {
  final LocalDbManager ldbm = LocalDbManager();
  final RemoteDbManager rdbm = RemoteDbManager();

  Future<List<SavingsGoals>> fSavingGoals(String uid) async =>
      rdbm.fetchRemoteSavingsGoals(uid);

  Future<List<SavingsGoals>> iSavingsGoals() async =>
      await ldbm.getSavingsGoal();

  deleteGoalFromLocalDB(SavingsGoals goal) async =>
      await ldbm.deleteSavingsGoalsById(goal);

  deleteGoalFromServer(SavingsGoals goal) async =>
      await rdbm.deleteSavingsGoals(goal);

  updateGoalsInLocalDB(List<SavingsGoals> goals) async {
    await ldbm.updateSavingsGoals(goals);
  }

  updateSavingsGoals(List<SavingsGoals> goals, String uid) async {
    rdbm.updateSavingsGoalInServer(goals, uid);
  }

  closeDB() async => await ldbm.clearDb();

  Future<List<SavingsTransactions>> iSavingsTransactions() async =>
      ldbm.getSavingsTransactions();

  updateSavingsTransactions(List<SavingsTransactions> txn) async {
    ldbm.updateSavingsTransactions(txn);
  }

  Future<List<Expenses>> iExpenses() async => ldbm.getExpenses();

  updateExpenses(List<Expenses> exp) async {
    ldbm.updateExpenses(exp);
  }

  Future<List<SavingsTransactions>> fSavingTxns() async =>
      rdbm.fetchRemoteSavingsTransactions();

  Future<List<Expenses>> fExpenses() async => rdbm.fetchRemoteExpenses();


  Future<List<Category>> fCategories() async => rdbm.getCategories();

  Future<List<Category>> iCategories() async => ldbm.getCategories();

  Future getCurrentUser(ATSaveUser user) async => await ldbm.saveUser(user);

  Future<int?> saveGoal(SavingsGoals goal) async =>
      await ldbm.addSavingsGoal(goal);

  Future saveTransaction(SavingsTransactions txn) async =>
      await ldbm.addSavingsTransactions(txn);


  Future<List<ATSaveUser>> getAllUsers() async => await ldbm.getUser();

  saveSavingsGoalsToServer(SavingsGoals goal) =>
      rdbm.saveSavingsGoalToServer(goal);

  saveSavingsTransactionsToServer(SavingsTransactions txn) =>
      rdbm.saveSavingsTransactionsToServer(txn);
}
