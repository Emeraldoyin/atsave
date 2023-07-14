import 'package:easysave/model/atsave_user.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:flutter/foundation.dart';

import '../manager/local_db_manager.dart';
import '../manager/remote_db_manager.dart';

class DatabaseRepository {
  final LocalDbManager ldbm = LocalDbManager();
  final RemoteDbManager rdbm = RemoteDbManager();

  Future<List<SavingsGoals?>?> fSavingGoals() async =>
      rdbm.fetchRemoteSavingsGoals();

  Future<List<SavingsGoals>> iSavingsGoals() async => ldbm.getSavingsGoal();

  updateSavingsGoals(List<SavingsGoals> goals) async {
    rdbm.updateSavingsGoalInServer(goals);
  }

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

  // Future<List<Lesson>> lessonsForCategory(int categoryId) async =>
  //     await ldbm.getLessonsForCategoryId(categoryId);

  // Future<List<Topic>> topicsForLesson(int lessonId, int categoryId) async =>
  //     await ldbm.getTopicByLessonId(lessonId, categoryId);

  // Future saveSelectedLesson(SelectedLesson selectedLesson) async {
  //   return await ldbm.addSelectedLesson(selectedLesson);
  // }

  closeDb() async => await ldbm.clearDb();

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

  // Future saveSelectedLessonToServer(SelectedLesson selectedLesson) async {
  //   await rdbm.saveSelectedLesson(SelectedLesson(
  //     lessonId: selectedLesson.lessonId,
  //     progressPercentage: selectedLesson.progressPercentage,
  //     userId: selectedLesson.userId,
  //     noOfTopics: selectedLesson.noOfTopics,
  //   ));
  // }
}