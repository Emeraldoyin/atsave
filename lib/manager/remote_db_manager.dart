import 'dart:developer';

import 'package:easysave/model/expenses.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/model/savings_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/category.dart';

class RemoteDbManager {
  final FirebaseDatabase db = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future<List<SavingsGoals>> fetchRemoteSavingsGoals(String uid) async {
    List<SavingsGoals> goals = [];

    final snapshot = await db.ref().child('SavingsGoals').child(uid).get();

    for (var element in snapshot.children) {
      if (element.value != null) {
        var data = element.value as Map<Object?, Object?>;
        log(data.toString(), name: 'elements');
        // Create a new SavingsGoals object and set its properties manually
        SavingsGoals goal = SavingsGoals(
          id: (data['id'] as int?),
          uid: uid,
          targetAmount: (data['targetAmount'] as num).toDouble(),
          goalNotes: data['goalNotes'] as String?,
          categoryId: data['categoryId'] as int,
          currentAmount: double.parse(data['startAmount'].toString()),
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

  deleteSavingsGoals(SavingsGoals goal) async {
    await db
        .ref()
        .child('SavingsGoals')
        .child(goal.uid)
        .child(goal.id.toString())
        .remove();
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

  Future<void> saveSavingsGoalToServer(SavingsGoals goal) async {
    await db
        .ref()
        .child('SavingsGoals')
        .child(goal.uid.toString())
        .child(goal.id.toString())
        .set({
      "id": goal.id,
      "uid": goal.uid,
      "targetAmount": goal.targetAmount,
      "goalNotes": goal.goalNotes,
      "categoryId": goal.categoryId,
      "startAmount": goal.currentAmount.toString(),
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

  Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    final snapshot = await db.ref().child('Category').get();

    for (var element in snapshot.children) {
      if (element.value != null) {
        var data = element.value as Map<Object?, Object?>;
        log(data.toString(), name: 'category');
        // Create a new SavingsGoals object and set its properties manually
        Category category = Category(
          name: (data['name'] as String),
          imagePath: (data['imagePath'] as String),
          id: data['id'] as int,
        );

        categories.add(category);
      } else {
        log('no data');
      }
    }
    return categories;
  }

  Future<void> updateSavingsGoalInServer(
      List<SavingsGoals> goals, String uid) async {
    await db.ref().child('SavingsGoals/$uid').remove();

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
        "startAmount": goal.currentAmount,
        "endDate": goal.endDate.toIso8601String(),
        "progressPercentage": goal.progressPercentage.toStringAsFixed(2)
      });
    }
  }
}
