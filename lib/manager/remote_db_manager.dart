import 'dart:convert';

import 'package:easysave/model/expenses.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/model/savings_transactions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import '../model/category.dart';

///This is the class that contains functions and variables that handles remote services to and from the remote server (Firebase realtime database).
class RemoteDbManager {
  /// The reference to the Firebase RealTime Database collection.
  final FirebaseDatabase db = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  ///this is called when a user wants to login.
  ///it verifies that the user has details in firebase and is authentic
  Future<String> login(String email, String password) async {
    final user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return user.user!.uid;
  }

  ///this is called when a user wants to sign up.
  ///it saves the users credentials in the realtime database and creates a new user in the firebase authentication system
  Future<UserCredential> signUp(String email, String? password,
      String createdAt, String firstName, String lastName) async {
    final UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password!);
    final databaseReference = FirebaseDatabase.instance.ref();
    // await FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
    await databaseReference.child('User').child(credential.user!.uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      "uid": credential.user!.uid,
      'createdAt': DateTime.now().toIso8601String(),
    });
    return credential;
  }

  ///fetches all collections [SavingsGoals] from firebase
  Future<List<SavingsGoals>> fetchRemoteSavingsGoals(String uid) async {
    List<SavingsGoals> goals = [];

    final snapshot = await db.ref().child('SavingsGoals').child(uid).get();

    for (var element in snapshot.children) {
      if (element.value != null) {
        var data = element.value as Map<Object?, Object?>;

        // Create a new SavingsGoals object and setting its properties manually
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
      }
    }

    return goals;
  }

  ///fetches all collections [SavingsTransactions] from firebase
  Future<List<SavingsTransactions>> fetchRemoteSavingsTransactions(
      String uid) async {
    List<SavingsTransactions> savingsTransactions = [];

    final snapshot =
        await db.ref().child('SavingsTransactions').child(uid).get();

    for (var element in snapshot.children) {
      if (element.value != null) {
        var data = element.value as Map<Object?, Object?>;

        // Create a new SavingsTransaction object and setting its properties manually
        SavingsTransactions txn = SavingsTransactions(
          id: (data['id'] as int?),
          uid: uid,
          timeStamp: DateTime.parse(data['timeStamp'] as String),
          amountSaved: double.parse(data['amountSaved'].toString()),
          amountExpended: (data['amountExpended'] as num).toDouble(),
        );

        savingsTransactions.add(txn);
      }
    }

    return savingsTransactions;
  }

  ///fetches all collections [Categories] from firebase
  Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    final snapshot = await db.ref().child('Category').get();

    for (var element in snapshot.children) {
      if (element.value != null) {
        var data = element.value as Map<Object?, Object?>;

        // Create a new Category object and setting its properties manually
        Category category = Category(
          name: (data['name'] as String),
          imagePath: (data['imagePath'] as String),
          id: data['id'] as int,
        );

        categories.add(category);
      }
    }
    return categories;
  }

  ///fetches all collections [Expenses] from firebase
  Future<List<Expenses>> fetchRemoteExpenses(String uid) async {
    List<Expenses> expenses = [];

    final snapshot = await db.ref().child('Expenses').child(uid).get();

    for (var element in snapshot.children) {
      if (element.value != null) {
        var data = element.value as Map<Object?, Object?>;

        // Create a new Expenses object and setting its properties manually
        Expenses expense = Expenses(
          id: (data['id'] as int?),
          uid: uid,
          date: DateTime.parse(data['date'] as String),
          amountSpent: double.parse(data['amountSpent'].toString()),
          savingsId: (data['savingsId'] as int),
        );

        expenses.add(expense);
      }
    }
    return expenses;
  }

  ///saves a new goal to server
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

//saves a new transaction to server
  Future<void> saveSavingsTransactionsToServer(SavingsTransactions txn) async {
    await db
        .ref()
        .child('SavingsTransactions')
        .child(txn.uid)
        .child(txn.id.toString())
        .set({
      "uid": txn.uid,
      "savingsId": txn.savingsId,
      "amountSaved": txn.amountSaved,
      "timeStamp": txn.timeStamp.toIso8601String(),
      "amountExpended": txn.amountExpended,
    });
  }

  ///saves a new expense to server
  Future<void> saveExpensesToServer(Expenses exp) async {
    await db
        .ref()
        .child('Expenses')
        .child(exp.uid)
        .child(exp.id.toString())
        .set({
      "uid": exp.uid,
      "savingsId": exp.savingsId,
      "amountSpent": exp.amountSpent,
      "date": exp.date.toIso8601String(),
    });
  }

//updateds server with new list of goals
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

  ///updates server with new list of transactions
  Future<void> updateSavingsTransactionsInServer(
      List<SavingsTransactions> transactions, String uid) async {
    await db.ref().child('SavingsTransactions/$uid').remove();

    for (var transaction in transactions) {
      await db
          .ref()
          .child('SavingsTransactions')
          .child(transaction.uid.toString())
          .child(transaction.id.toString())
          .set({
        "uid": transaction.uid,
        "savingsId": transaction.savingsId,
        "amountSaved": transaction.amountSaved,
        "amountExpended": transaction.amountExpended,
        "timeStamp": transaction.timeStamp,
      });
    }
  }

  ///updates server with new list of expenses
  Future<void> updateExpensesInServer(
      List<Expenses> expenses, String uid) async {
    await db.ref().child('Expenses/$uid').remove();

    for (var expense in expenses) {
      await db
          .ref()
          .child('Expenses')
          .child(expense.uid.toString())
          .child(expense.id.toString())
          .set({
        "uid": expense.uid,
        "savingsId": expense.savingsId,
        "amountSpent": expense.amountSpent,
        "date": expense.date.toIso8601String(),
      });
    }
  }

  ///deletes goal
  deleteSavingsGoals(SavingsGoals goal) async {
    // deleting SavingsGoal object from server
    await db
        .ref()
        .child('SavingsGoals')
        .child(goal.uid)
        .child(goal.id.toString())
        .remove();
  }

  deleteExpenses(Expenses expense) async {
    // deleting Expenses object from server
    await db
        .ref()
        .child('Expenses')
        .child(expense.uid)
        .child(expense.id.toString())
        .remove();
  }

  deleteSavingsTransaction(SavingsTransactions txn) async {
    // deleting SavingsTransactions object from server
    await db
        .ref()
        .child('SavingsTransactions')
        .child(txn.uid)
        .child(txn.id.toString())
        .remove();
  }

  ///logs out a user
  Future<String> logout(String email, String password) async {
    final user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return user.user!.uid;
  }

  ///called when a push notification is to be sent to user device
  Future<void> sendPushNotification(
      String deviceToken, String title, String body) async {
    const url =
        'https://fcm.googleapis.com/v1/projects/atsave-2db27/messages:send';
//holds the auth token to be refreshed
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ya29.a0AbVbY6OB6qf0ihjO9n7vQSKboAa1xJh4CjqXDW40fIJtvheKIiXvsCjhj_qiuBAmgRLVfIMUXLDCln5MOKTydazm1H07LVpzZiPqL3xyyrnOLMUy3fAGELkdpdOag3XRY9MLkij9neQ2pRBAoqZbW6TAmsIOcgQaCgYKAZkSARESFQFWKvPlP55Hp14OB1GRfcrOfP1gyQ0166',
    };

    final message = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': title,
          'body': body,
        },
      },
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(message));

    if (response.statusCode == 200) {
    } else {}
  }
}
