import 'dart:async';

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
        SavingsTransactionsSchema
      ],
      directory: (await getApplicationSupportDirectory()).path,
    );
  }

  Future<void> clearDb() async {
    await _isar?.writeTxn(() async {
      _isar?.aTSaveUsers.clear();
      _isar?.savingsGoals.clear();
      _isar?.savingsTransactions.clear();
    });
  }

  Future<List<ATSaveUser>> getUser() async {
    return _isar!.writeTxn(() async {
      return _isar!.aTSaveUsers.where().findAll();
    });
  }

  Future<void> addSavingsGoal(SavingsGoals goal) async {
    await _isar?.writeTxn(() async {
      await _isar?.savingsGoals.put(goal);
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

  Future<void> storeCategories() async {
    List<Category> categoryList = [
      Category(name: 'Food', imagePath: 'assets/images/food.jpeg'),
      Category(name: 'Car', imagePath: 'assets/images/car.jpeg'),
      Category(name: 'Events', imagePath: 'assets/images/events.jpeg'),
      Category(name: 'Family Needs', imagePath: 'assets/images/family.jpeg'),
      Category(name: 'Apartment', imagePath: 'assets/images/apartment.jpeg'),
      Category(name: 'Utility Bills', imagePath: 'assets/images/bills.jpeg'),
      Category(
          name: 'Non-specified',
          imagePath: 'assets/images/open home_safe_with_money.png'),
      Category(name: 'Travels', imagePath: 'assets/images/travels.jpeg')
    ];
    await _isar?.writeTxn(() async {
      await _isar?.categorys.putAll(categoryList);
    });
  }

  Future<List<SavingsGoals>> getSavingsGoal() async {
    return _isar!.writeTxn(() async {
      return _isar!.savingsGoals.where().findAll();
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
    SavingsGoals? formerGoal =
        await _isar!.savingsGoals.filter().idEqualTo(goal.id).findFirst();
    if (formerGoal != null) {
      formerGoal = goal;
    }
    await _isar!.savingsGoals.put(formerGoal!);
    await _isar!.close();
  }

  Future deleteSavingsGoalsById(SavingsGoals goal) async {
    await _isar!.savingsGoals.delete(goal.id!);
    await _isar!.close();
  }

  Future clearTxnByUserId(String uid) async {
    await _isar!.savingsTransactions.filter().uidEqualTo(uid).deleteAll();
    await _isar!.close();
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


  // Future<List<Lesson>> getLessons() async {
  //   return _isar!.writeTxn(() async {
  //     return _isar!.lessons.where().findAll();
  //   });
  // }

  // Future<List<Lesson>> getLessonsForCategoryId(int categoryId) async {
  //   List<Lesson> lessons =
  //       await _isar!.lessons.filter().categoryIdEqualTo(categoryId).findAll();
  //   return lessons;
  // }

  // Future<List<Topic>> getTopics() async {
  //   return _isar!.writeTxn(() async {
  //     return _isar!.topics.where().findAll();
  //   });
  // }

  

  // Future updateQuizzes(List<Quiz> quiz) async {
  //   return _isar!.writeTxn(() async {
  //     await _isar!.quizs.clear();

  //     return _isar!.quizs.putAll(quiz);
  //   });
  // }

  // Future updateLessons(List<Lesson> course) async {
  //   return _isar!.writeTxn(() async {
  //     await _isar!.lessons.clear();

  //     return _isar!.lessons.putAll(course);
  //   });
  // }

  // Future<List<Topic>> getTopicByLessonId(int lessonId, int categoryId) async {
  //   return await _isar!.topics
  //       .filter()
  //       .categoryIdEqualTo(categoryId)
  //       .lessonIdEqualTo(lessonId)
  //       .findAll();
  // }

  // Future addSelectedLesson(SelectedLesson selectedLesson) async {
  //   return await _isar!
  //       .writeTxn(() async => await _isar!.selectedLessons.put(selectedLesson));
  // }

  // getAllSelectedLesson() async {
  //   return await _isar!.selectedLessons.where().findAll();
  // }

  // Future<SelectedLesson?> checkIfSelected(String uid, int lessonId) async {
  //   final query = await _isar!.selectedLessons
  //       .where()
  //       .filter()
  //       .userIdEqualTo(uid)
  //       .lessonIdEqualTo(lessonId)
  //       .build();
  //   final result = query.findFirst();
  //   return result;
  // }

  // hasLesson(int lessonid) async {
  //   final lesson = await _isar!.selectedLessons
  //       .filter()
  //       .lessonIdEqualTo(lessonid)
  //       .findFirst();
  //   if (lesson != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  //   SelectedLesson? selectedLesson = await _isar!.selectedLessons
  //       .filter()
  //       .lessonIdEqualTo(lessonId)
  //       .findFirst();
  //   log(selectedLesson.toString(), name: 'selected lesson');
  //   await _isar!.writeTxn(() async {
  //     if (selectedLesson!.completedTopics == null) {
  //       selectedLesson.completedTopics = [topicId];
  //       selectedLesson.progressPercentage = 100 / selectedLesson.noOfTopics! +
  //           selectedLesson.progressPercentage!;
  //       await _isar!.selectedLessons.put(selectedLesson);
  //     } else if (selectedLesson.completedTopics!.contains(topicId)) {
  //     } else {
  //       selectedLesson.completedTopics = [
  //         topicId,
  //         ...selectedLesson.completedTopics!
  //       ];
  //       selectedLesson.progressPercentage = 100 / selectedLesson.noOfTopics! +
  //           selectedLesson.progressPercentage!;
  //       await _isar!.selectedLessons.put(selectedLesson);
  //     }
  //   });
  // }

  // Future<TechKidUser> getUsersList() async {
  //   return await _isar!.techKidUsers
  //       .where()
  //       .findAll()
  //       .then((value) => value.first);
  // }

  // Future<void> increaseNoOfTopicsCompleted(String uid) async {
  //   TechKidUser? user =
  //       await _isar!.techKidUsers.filter().uidEqualTo(uid).findFirst();
  //   log(user.toString(), name: 'user on leaderboard');
  //   await _isar!.writeTxn(() async {
  //     if (user!.noOfTopicsCompleted == 0) {
  //       user.noOfTopicsCompleted = 1;

  //       await _isar!.techKidUsers.put(user);
  //     } else if (user.noOfTopicsCompleted! >= 1) {
  //       user.noOfTopicsCompleted = user.noOfTopicsCompleted! + 1;
  //       await _isar!.techKidUsers.put(user);
  //     }
  //   });
  // }
}
