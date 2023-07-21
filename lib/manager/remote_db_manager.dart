import 'dart:developer';

import 'package:easysave/model/expenses.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/model/savings_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// final databaseReference = FirebaseDatabase.instance.ref();
// final categoryReference = databaseReference.child("category");
// final dataSnapshot = categoryReference.once();

class RemoteDbManager {
  final FirebaseDatabase db = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  //int overallNoOfTopicsCompleted = 0;

  // Future<List<SavingsGoals>> fetchRemoteSavingsGoals(String uid) async {
  //   List<SavingsGoals> savingsGoals = [];

  //   final snapshot = await db.ref().child('SavingsGoals').child(uid).get();
  //   //  try {
  //   if (snapshot.exists) {
  //     Map<Object?, Object?> isarData = {};
  //     for (var element in snapshot.children) {
  //       if (element.value != null) {
  //         Object? convertedKey = element.key as String;
  //         Object? convertedValue = element.value;
  //         //  savingsGoals.add(
  //         //      SavingsGoals.fromJson(element.value as Map<Object?, Object?>));
  //         // Store the converted key-value pair in the isarData map
  //         // isarData[convertedKey] = convertedValue;
  //         //  log(isarData.toString(), name: 'isar');
  //         savingsGoals.add(
  //             SavingsGoals.fromJson(element.value as Map<Object?, Object?>));
  //         log(savingsGoals.toString(), name: 'new goals');
  //       } else {
  //         log(element.children.toString(), name: 'null values');
  //       }
  //     }
  //   }

  //   // } catch (e) {
  //   //   log(e.toString(), name: 'Firebase');
  //   // }
  //   return savingsGoals;
  // }

  Future<List<SavingsGoals>> fetchRemoteSavingsGoals(String uid) async {
    List<SavingsGoals> goals = [];

    final snapshot = await db.ref().child('SavingsGoals').child(uid).get();

    for (var element in snapshot.children) {
      if (element.value != null) {
        var data = element.value as Map<Object?, Object?>;
        log(data.toString(), name: 'elements');
        // Create a new SavingsGoals object and set its properties manually
        SavingsGoals goal = SavingsGoals(
          uid: uid,
          targetAmount: (data['targetAmount'] as num).toDouble(),
          goalNotes: data['goalNotes'] as String?,
          categoryId: data['categoryId'] as int,
          startAmount: double.parse(data['startAmount'].toString()),
          endDate: DateTime.parse(data['endDate'] as String),
          progressPercentage:
              double.parse(data['progressPercentage'] as String),
        );

        goals.add(goal);
        log(goals.toString(), name: 'goals');
      } else {
        log('no data');
      }
    }

    return goals;
  }

  Future<List<SavingsTransactions>> fetchRemoteSavingsTransactions() async {
    List<SavingsTransactions> savingsTransactions = [];

    final snapshot =
        await db.ref().child('SavingsTransactions').child('id').get();
    try {
      if (snapshot.exists) {
        Map<String, dynamic> isarData = {};
        for (var element in snapshot.children) {
          String? convertedKey = element.key.toString();
          dynamic convertedValue = element.value;

          // Store the converted key-value pair in the isarData map
          isarData[convertedKey] = convertedValue;

          savingsTransactions.add(SavingsTransactions.fromJson(isarData));
        }
      }
    } on FirebaseAuthException catch (e) {
      log(e.message.toString(), name: 'Firebase');
    }
    return savingsTransactions;
  }

  Future<List<Expenses>> fetchRemoteExpenses() async {
    List<Expenses> expenses = [];

    final snapshot = await db.ref().child('Expenses').child('id').get();
    try {
      if (snapshot.exists) {
        Map<String, dynamic> isarData = {};
        for (var element in snapshot.children) {
          String? convertedKey = element.key.toString();
          dynamic convertedValue = element.value;

          // Store the converted key-value pair in the isarData map
          isarData[convertedKey] = convertedValue;

          expenses.add(Expenses.fromJson(isarData));
        }
      }
    } on FirebaseAuthException catch (e) {
      log(e.message.toString(), name: 'Firebase');
    }
    return expenses;
  }

  // Future<List<SavingsGoals>> fetchRemoteSavingsGoals(String uid) async {

  //   final snapshot = await db.ref().child('SavingsGoals').child(uid).get();
  //   try {
  //     if (snapshot.exists) {
  //       final List<SavingsGoals> goals = snapshot.children.map((e) {
  //         final data = e.children as Map<String, dynamic>;
  //       if (data != null){SavingsGoals.fromJson(data)}
  //       else{log('no data available')}}).toList(); return goals;

  //     }
  //   } on FirebaseAuthException catch (e) {
  //     log(e.message.toString(), name: 'Firebase');
  //   }

  // }

  Future<void> saveSavingsGoalToServer(SavingsGoals goal) async {
    await db
        .ref()
        .child('SavingsGoals')
        .child(goal.uid.toString())
        .child(goal.id.toString())
        .set({
      "uid": goal.uid,
      "targetAmount": goal.targetAmount,
      "goalNotes": goal.goalNotes,
      "categoryId": goal.categoryId,
      "startAmount": goal.startAmount.toString(),
      "endDate": goal.endDate.toIso8601String(),
      "progressPercentage": goal.progressPercentage.toStringAsFixed(2)
    });
  }

  Future<void> saveSavingsTransactionsToServer(SavingsTransactions txn) async {
    await db.ref().child('SavingsTransactions').child(txn.id.toString()).set({
      "uid": txn.uid,
      "savingsId": txn.savingsId,
      "amountSaved": txn.amountSaved,
      "timeStamp": txn.timeStamp.toIso8601String(),
      "amountExpended": txn.amountExpended,
    });
  }

  Future<void> updateSavingsGoalInServer(List<SavingsGoals> goals) async {
    for (var goal in goals) {
      await db
          .ref()
          .child('SavingsGoals')
          .child(goal.uid.toString())
          .child(goal.id.toString())
          .set({
        "uid": goal.uid,
        "targetAmount": goal.targetAmount,
        "goalNotes": goal.goalNotes,
        "categoryId": goal.categoryId,
        "startAmount": goal.startAmount,
        "endDate": goal.endDate.toIso8601String(),
        "progressPercentage": goal.progressPercentage.toStringAsFixed(2)
      });
    }
  }

  // Future<List<SavingsGoals>> fetchRemoteSavingsGoals(String uid) async {
  //   final snapshot = await ref.child('SavingsGoals/$uid').once();
  //   final goalMap = snapshot.snapshot.value as Map<String?, dynamic>;
  //   log(goalMap.toString(), name: 'goalMap');
  //   final savingsGoalData = <SavingsGoals>[];

  //   // for (var element in goalMap.entries) {
  //   //   savingsGoalData.add(SavingsGoals.fromJson(element.value as Map<Object?, Object?>));
  //   // }
  //   for (var value in goalMap) {
  //     if (value != null) {
  //       log(value.toString());
  //     }
  //   }
  //   return savingsGoalData;
  // }

// Future<User?> googlesignIn() async {
//    FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;

//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     final GoogleSignInAccount? googleSignInAccount =
//         await googleSignIn.signIn();

//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       try {
//         final UserCredential userCredential =
//             await auth.signInWithCredential(credential);

//         user = userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           showSnackBar(
//               context,
//               'The account already exists with a different credential.',
//               Colors.black);
//         } else if (e.code == 'invalid-credential') {
//           showSnackBar(
//               context,
//               'Error occurred while accessing credentials. Try again.',
//               Colors.black);
//           // handle the error here
//         }
//       } catch (e) {
//         // handle the error here
//         showSnackBar(
//             context,
//             const Text('Error occurred while using Google Sign-In. Try again'),
//             Colors.black);
//       }
//     }

//     return user;
//   }

//   Future<List<Quiz>> getQuizzes() async {
//     List<Quiz> quizzes = [];
//     final snapshot = await db.ref().child('Quiz').get();
//     for (var element in snapshot.children) {
//       quizzes.add(Quiz.fromJson(element.value as Map<Object?, Object?>));
//     }
// // log(quizzes.toString());
//     return quizzes;
//   }

//   Future<List<Lesson>> getLessons() async {
//     List<Lesson> lessons = [];
//     final snapshot = await db.ref().child('Lessons').get();
// // log(snapshot.children.first.value.runtimeType.toString());
//     for (var element in snapshot.children) {
//       lessons.add(Lesson.fromJson(element.value as Map<Object?, Object?>));
//     }
//     return lessons;
//   }

//   Future<List<Topic>> getTopics() async {
//     List<Topic> topics = [];
//     final snapshot = await db.ref().child('Topic').get();
//     for (var element in snapshot.children) {
//       topics.add(Topic.fromJson(element.value as Map<Object?, Object?>));
//     }
//     return topics;
//   }

  // Future<List<LeaderBoardEntry>> getLeaderboardEntries() async {
  //   List<LeaderBoardEntry> leaderboardEntries = [];
  //   final snapshot = await databaseReference.child('LeaderBoard').get();
  //   for (var element in snapshot.children) {
  //     leaderboardEntries.add(
  //         LeaderBoardEntry.fromJson(element.value as Map<Object?, Object?>));
  //   }

  //   return leaderboardEntries;
  // }

  // saveLeaderBoardEntryToServer(List<SelectedLesson?> selectedLessonList) async {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  //   log(selectedLessonList.first!.completedTopics.toString(), name: 'lenght');
  //   int total = 0;
  //   for (var selectedLesson in selectedLessonList) {
  //     if (selectedLesson!.completedTopics != null) {
  //       total += selectedLesson.completedTopics!.length;
  //     }
  //   }
  //   final displayName = await LocalDbManager()
  //       .getUsersList()
  //       .then((value) => '${value.firstName} ${value.lastName}');
  //   await db.ref().child('LeaderBoard').child(uid).set({
  //     "displayName": displayName,
  //     "noOfTopicsCompleted": total,
  //   });
  //   log(total.toString(), name: 'number of topics completed');
  //   //   }

  //   // int complete = selectedLessonList.forEach((lesson)=>lesson.completedTopics!.length);
  // }

  // Future<void> saveLeaderBoardEntry(List<LeaderBoardEntry?> entry) async {
  //   entry.forEach((element) async {
  //     await db.ref().child('LeaderBoard').child(element!.userId).set({
  //       "displayName": element.displayName,
  //       "noOfTopicsCompleted": element.noOfTopicsCompleted
  //     });
  //   });
  // }

  // Future<void> saveAllSelectedLessons(
  //     List<SelectedLesson?> selectedLesson) async {
  //   selectedLesson.forEach((element) async {
  //     await db
  //         .ref()
  //         .child('SelectedLesson')
  //         .child(element!.userId!)
  //         .child(element.lessonId.toString())
  //         .set({
  //       "lessonId": element.lessonId,
  //       "userId": element.userId,
  //       "progressPercentage": element.progressPercentage,
  //       "noOfTopics": element.noOfTopics
  //     });
  //   });
  // }

  // Future editProgressPercentage(int lessonId, String userId, int progressValue){

  // }

// DatabaseReference starCountRef =
//         ref('posts/$postId/starCount');
// starCountRef.onValue.listen((DatabaseEvent event) {
//     final data = event.snapshot.value;
//     updateStarCount(data);
// });

//   Future<String> checkUser() async {
//     final event = await ref.once(DatabaseEventType.value);
//     final username = event.snapshot.value?.username ?? 'Anonymous';
//   }
}
