import 'dart:developer';

import 'package:easysave/model/savings_goals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// final databaseReference = FirebaseDatabase.instance.ref();
// final categoryReference = databaseReference.child("category");
// final dataSnapshot = categoryReference.once();

class RemoteDbManager {
  final FirebaseDatabase db = FirebaseDatabase.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  //int overallNoOfTopicsCompleted = 0;

  Future<List<SavingsGoals?>?> fetchRemoteSavingsGoals() async {
    List<SavingsGoals> savingsGoals = [];
    final snapshot = await db.ref().child('SavingsGoals').get();
    try {
      if (snapshot.exists) {
        for (var element in snapshot.children) {
          savingsGoals.add(
              SavingsGoals.fromJson(element.value as Map<Object?, Object?>));
        }
      }
    } on FirebaseAuthException catch (e) {
      log(e.message.toString(), name: 'Firebase');
    }
    return savingsGoals;
  }
  // Future<List<SavingsGoals?>?> fetchRemoteSavingsGoals() async {
  //   final snapshot = await ref.child('SavingsGoals').once();
  //   final goalMap = snapshot.snapshot.value as Map<Object?, dynamic>;

  //   final savingsGoalData = <SavingsGoals>[];
  //   // loop through each user in the database
  //   for (var element in goalMap.entries) {
  //     categories.add(Category.fromJson(element.value as Map<Object?, Object?>));
  //   }
  //   goalMap.forEach((key, value) {
  //     final String uid = value['uid'];
  //     final double targetAmount = value['targetAmount'] ?? 'Unknown';
  //     final String goalNotes = value['goalNotes'] ?? 'None specified';
  //     final int categoryId = value['categoryId'];
  //     final Object id = key ?? '';
  //     final double startAmount = value['startAmount'];
  //     final DateTime endDate = value['endDate'];
  //     final double progressPercentage = value['progressPercentage'];
  //     savingsGoalData.add(SavingsGoals(
  //       categoryId: categoryId,
  //       uid: uid,
  //       targetAmount: targetAmount,
  //       progressPercentage: progressPercentage,
  //       endDate: endDate,
  //       startAmount: startAmount,
  //       goalNotes: goalNotes,
  //     ));
  //   });
  //   return savingsGoalData;
  // }

  Future<void> saveSavingsGoalToServer(SavingsGoals goal) async {
    await db.ref().child('SavingsGoals').child(goal.id.toString()).set({
      "uid": goal.uid,
      "targetAmount": goal.targetAmount,
      "goalNotes": goal.goalNotes,
      "categoryId": goal.categoryId,
      "startAmount": goal.startAmount.toString(),
      "endDate": goal.endDate.toString(),
      "progresssPercentage": goal.progressPercentage.toStringAsFixed(0)
    });
  }

  Future<void> updateSavingsGoalInServer(List<SavingsGoals> goals) async {
    for (var goal in goals) {
      await db.ref().child('SavingsGoals').child(goal.id.toString()).set({
        "uid": goal.uid,
        "targetAmount": goal.targetAmount,
        "goalNotes": goal.goalNotes,
        "categoryId": goal.categoryId,
        "startDate": goal.startAmount,
        "endDate": goal.endDate,
        "progresssPercentage": goal.progressPercentage.toStringAsFixed(0)
      });
    }
  }
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