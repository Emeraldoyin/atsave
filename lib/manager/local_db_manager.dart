import 'dart:async';

import 'package:easysave/model/atsave_user.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../model/category.dart';

class LocalDbManager {
  static Isar? _isar;

  static openDb() async {
    _isar = await Isar.open(
      [
        ATSaveUserSchema,
        SavingsGoalsSchema,
      ],
      directory: (await getApplicationSupportDirectory()).path,
    );
  }

  Future<void> clearDb() async {
    await _isar?.writeTxn(() async {
      _isar?.aTSaveUsers.clear();
      _isar?.savingsGoals.clear();
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
Future<void> storeCategories() async {
  List<Category> categoryList = [
    Category(name: 'Food', imagePath: 'assets/images/food.jpeg'),
    Category(name: 'Car', imagePath: 'assets/images/car.jpeg'),
    Category(name: 'Events', imagePath: 'assets/images/events.jpeg'),
    Category(name: 'Family Needs', imagePath: 'assets/images/family.jpeg'),
    Category(name: 'Apartment', imagePath: 'assets/images/apartment.jpeg'),
    Category(name: 'Utility Bills', imagePath: 'assets/images/bills.jpeg'), 
    Category(name: 'Non-specified', imagePath: 'assets/images/open home_safe_with_money.png'),
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

  Future updateCategories(List<SavingsGoals> category) async {
    return _isar!.writeTxn(() async {
      await _isar!.savingsGoals.clear();

      return _isar!.savingsGoals.putAll(category);
    });
  }

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

  // Future updateTopics(List<Topic> topic) async {
  //   return _isar!.writeTxn(() async {
  //     await _isar!.topics.clear();

  //     return _isar!.topics.putAll(topic);
  //   });
  // }

  // Saving user details in Isar
  Future saveUser(ATSaveUser newUser) async {
    return await _isar!.writeTxn(() async {
      return await _isar!.aTSaveUsers.put(newUser);
    });
  }

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

  // Future<void> increaseProgressValue(int lessonId, int topicId) async {
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
