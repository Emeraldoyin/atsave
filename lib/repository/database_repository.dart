import 'package:easysave/model/atsave_user.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/model/savings_transactions.dart';

import '../manager/local_db_manager.dart';
import '../manager/remote_db_manager.dart';
import '../model/expenses.dart';

class DatabaseRepository {
  final LocalDbManager ldbm = LocalDbManager();
  final RemoteDbManager rdbm = RemoteDbManager();

  Future<List<SavingsGoals>> fSavingGoals(String uid) async =>
      rdbm.fetchRemoteSavingsGoals(uid);

  Future<List<SavingsGoals>> iSavingsGoals() async => await ldbm.getSavingsGoal();

  // updateSavingsGoals(List<SavingsGoals> goals) async {
  //   ldbm.updateGoals(goals);
  // }
  updateGoalsInLocalDB(List<SavingsGoals> goals) async {
   await ldbm.updateSavingsGoals(goals);
  }

  updateSavingsGoals(List<SavingsGoals> goals) async {
    rdbm.updateSavingsGoalInServer(goals);
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

//List<Category> getCategory() async => ldbm.getCategory();

  // Future updateCategories(List<Category> category) async =>
  //     ldbm.updateCategories(category);

  // Future<List<Lesson>> iLessons() async => await ldbm.getLessons();

  // Future<List<Lesson>> fLessons() async => await rdbm.getLessons();

  // Future updateLessons(List<Lesson> lessons) async =>
  //     await ldbm.updateLessons(lessons);

  // Future<List<Topic>> iTopics() async => await ldbm.getTopics();

  // Future<List<Topic>> fTopics() async => await rdbm.getTopics();

  // Future updateTopics(List<Topic> topics) async =>
  //     await ldbm.updateTopics(topics);

  // Future<List<LeaderBoardEntry>> fEntries() async =>
  //     await rdbm.fetchLeaderboardData();

  // Future updateLeaderBoardEntries(List<LeaderBoardEntry> entries) async =>
  //     await rdbm.getLeaderboardEntries();

  Future getCurrentUser(ATSaveUser user) async => await ldbm.saveUser(user);

  Future saveGoal(SavingsGoals goal) async => await ldbm.addSavingsGoal(goal);

  Future saveTransaction(SavingsTransactions txn) async =>
      await ldbm.addSavingsTransactions(txn);

  // Future<List<Lesson>> lessonsForCategory(int categoryId) async =>
  //     await ldbm.getLessonsForCategoryId(categoryId);

  // Future<List<Topic>> topicsForLesson(int lessonId, int categoryId) async =>
  //     await ldbm.getTopicByLessonId(lessonId, categoryId);

  // Future saveSelectedLesson(SelectedLesson selectedLesson) async {
  //   return await ldbm.addSelectedLesson(selectedLesson);
  // }

  // Future<List<SelectedLesson>> getAllSelectedLessons() async =>
  //     await ldbm.getAllSelectedLesson();

  // Future<List<Quiz>> getAllQuizQuestions() async =>
  //     await ldbm.getQuizzes();

  Future<List<ATSaveUser>> getAllUsers() async => await ldbm.getUser();

  // Future incrementProgressValue(int lessonId, int topicId) async {
  //   await ldbm.increaseProgressValue(lessonId, topicId);
  // }

  // Future IncrementNoOfTopicsCompleted(String uid) async =>
  //     await ldbm.increaseNoOfTopicsCompleted(uid);

  saveSavingsGoalsToServer(SavingsGoals goal) =>
      rdbm.saveSavingsGoalToServer(goal);

  saveSavingsTransactionsToServer(SavingsTransactions txn) =>
      rdbm.saveSavingsTransactionsToServer(txn);

  // Future saveSelectedLessonToServer(SelectedLesson selectedLesson) async {
  //   await rdbm.saveSelectedLesson(SelectedLesson(
  //     lessonId: selectedLesson.lessonId,
  //     progressPercentage: selectedLesson.progressPercentage,
  //     userId: selectedLesson.userId,
  //     noOfTopics: selectedLesson.noOfTopics,
  //   ));
  // }
}
