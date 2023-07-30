import 'dart:developer';

import 'package:easysave/bloc_folder/auth_bloc/authentication_bloc.dart';
import 'package:easysave/bloc_folder/database_bloc/database_bloc.dart';
import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/consts/app_images.dart';
import 'package:easysave/controller/signup/success_controller.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/model/savings_transactions.dart';
import 'package:easysave/utils/helpers/double_parser.dart';
import 'package:easysave/view/pages/add_savings_goal_page.dart';
import 'package:easysave/view/pages/error_page.dart';
import 'package:easysave/view/pages/homepage.dart';
import 'package:easysave/view/pages/my_expenses_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../consts/app_texts.dart';
import '../../model/category.dart';
import '../../model/expenses.dart';
import '../../utils/helpers/comma_formatter.dart';
import '../../utils/helpers/session_manager.dart';
import '../../view/pages/my_goals_page.dart';
import '../signin/signin_controller.dart';

///This is the controller class for the Home screen.
///It controlls the homepage which includes the dashboard and its two pages[MyGoalsPage] and [MyExpenses], the other pages in the navbar.
class Home extends StatefulWidget {
  const Home(
      {Key? key,
      this.categories,
      this.allExpenses,
      this.allGoals,
      this.allTransactions})
      : super(key: key);
  final List<Category>? categories;
  final List<SavingsTransactions>? allTransactions;
  final List<SavingsGoals>? allGoals;
  final List<Expenses>? allExpenses;
  @override
  HomePageController createState() => HomePageController();
}

class HomePageController extends State<Home>
    with SingleTickerProviderStateMixin {
  //... //Initialization code, state vars etc,
  int currentIndex = 0;
  final addGoalFormKey = GlobalKey<FormState>();
  TabController? tabController;
  int selectedIndex = 0;
  String? selectedCategory;
  String? username;
  late DateTime date;
  List<SavingsGoals> allGoals = [];
  List<SavingsTransactions> allTransactions = [];
  List<Expenses> allExpenses = [];
  SavingsGoals? newlyAddedGoal;
  RegExp decimalRegex = RegExp(r'^-?\d+\.?\d*$');
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController targetAmountController = TextEditingController();
  TextEditingController goalNotesController = TextEditingController();
  TextEditingController startAmountController = TextEditingController();
  TextEditingController proposedEndDateController = TextEditingController();
  SessionManager manager = SessionManager();
  double alreadySaved = 0;
  double totalAmount = 0;
  double remainingAmount = 0;
  // List<PieData> getPieData() {
  // // double remainingAmount = totalTarget - totalSaved;
  //           return [
  //             PieData('Already Saved', totalSaved),
  //             PieData('Remaining', remainingAmount),
  //           ];
  //         }

  //         List<PieData> data = getPieData();

  onCategoryClicked(value) {
    setState(() {
      selectedCategory = value;
    });
  }

  ///returns the items of bottom navbar with a default
  BottomNavigationBarItem navbar({
    required IconData icon,
    required String label,
    value,
  }) {
    return BottomNavigationBarItem(
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      icon: Icon(
        icon,
      ),
      label: label,
    );
  }

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    allTransactions = widget.allTransactions ?? [];
    context.read<ConnectivityBloc>().add(RetrieveDataEvent(uid: user!.uid));
    tabController = TabController(length: 2, vsync: this);
    getUsername();
  }

//returns displayName of user
  Future<String> getUsername() async {
    username = await manager.getUsername();
    if (username == null) {
      return 'Unknown';
    } else {
      return username ?? '';
    }
  }

  ///disposing all controller used
  @override
  void dispose() {
    tabController?.dispose();
    targetAmountController.dispose();
    startAmountController.dispose();
    proposedEndDateController.dispose();
    goalNotesController.dispose();
    super.dispose();
  }

  ///changes tab view
  onClick() {
    tabController?.animateTo(selectedIndex += 1);
  }

  ///validators for text field
  String? validate(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    } else {
      return null;
    }
  }

  String? validateAmount(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    } else if (value == 0) {
      return 'Invalid amount to save';
    } else {
      return null;
    }
  }

  String? validateCategory(value) {
    if (value == null) {
      return 'Field cannot be empty';
    } else if (value == 0) {
      return 'Invalid amount to save';
    } else {
      return null;
    }
  }

  String getTotalTargetAmount(List<SavingsGoals> goals) {
    List<double> targetAmounts =
        goals.map((goal) => goal.targetAmount.toDouble()).toList();
    totalAmount = targetAmounts.reduce((value, element) => value + element);

    return formatDoubleWithComma(totalAmount);
  }

  String getAlreadySaved(List<SavingsGoals> goals) {
    List<double> currentAmounts =
        goals.map((goal) => goal.currentAmount.toDouble()).toList();
    alreadySaved = currentAmounts.reduce((value, element) => value + element);

    return formatDoubleWithComma(alreadySaved);
  }

  List<PieData> getPieData() {
    remainingAmount = totalAmount - alreadySaved;
    return [
      PieData('Already Saved', alreadySaved),
      PieData('Remaining', remainingAmount),
    ];
  }

  String getProgressMade(List<SavingsGoals> goals) {
    List<double> progressPercentages =
        goals.map((goal) => goal.progressPercentage).toList();
    double totalProgressSum =
        progressPercentages.reduce((value, element) => value + element);
    double totalProgress =
        totalProgressSum / (progressPercentages.length * 100) * 100;
    return totalProgress.toStringAsFixed(1);
  }

  ///handles the event called on add new goal
  onSaveGoal() async {
    String inputText = proposedEndDateController.text;
    DateFormat inputFormat = DateFormat("EEEE, MMM d, y");
    DateTime dateTime = inputFormat.parse(inputText);
    double targetAmount = parseStringToDouble(targetAmountController.text);
    double startingAmount = parseStringToDouble(startAmountController.text);
    double progressPercentage = startingAmount / targetAmount * 100;
    if (startingAmount > targetAmount) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'The amount you\'re saving now should be less the target amount.'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        backgroundColor: APPBAR_COLOR2,
      ));
    } else {
      if (addGoalFormKey.currentState!.validate()) {
        ///creating a savingsgoal instance that will be used to save the object in database
        SavingsGoals newlyAddedGoal = SavingsGoals(
            uid: user?.uid ?? '',
            targetAmount: targetAmount,
            categoryId: categoryList
                .indexWhere((element) => element.name == selectedCategory),
            currentAmount: startingAmount,
            endDate: dateTime,
            progressPercentage:
                double.parse(progressPercentage.toStringAsFixed(2)),
            goalNotes: goalNotesController.text);

        ///creating a savingstransaction instance that will be saved in database
        SavingsTransactions newTxn = SavingsTransactions(
            savingsId: newlyAddedGoal.id,
            amountExpended: 0,
            amountSaved: newlyAddedGoal.currentAmount,
            timeStamp: DateTime.now(),
            uid: user?.uid ?? '');
        context
            .read<DatabaseBloc>()
            .add(AddSavingsGoalsEvent(goal: newlyAddedGoal, txn: newTxn));

        //  context.read<DatabaseBloc>().add(SaveTransactionEvent(txn: newTxn));

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Success(
                      buttonText: 'Done',
                      displayImageURL: image17,
                      displayMessage: 'Congratulations!!!',
                      succcessful: true,
                      displaySubText: 'You just added a new savings goals.',
                      destination: HomePage(this),
                    )));
      }
    }
  }

  ///listeners for bloc states emitted
  firstListener(state) {
    if (state is AuthLoadingState) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Waiting for network...'),
        duration: Duration(seconds: 2),
      ));
    }
    if (state is LogoutSuccessState) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        SessionManager manager = SessionManager();
        manager.loggedIn(false);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('you have been successfully logged out'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ));
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignIn()));
    }
    if (state is AuthErrorState) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ErrorPage()));
    }
  }

  secondListener(state2) {
    if (state2 is DbLoadingState) {
      const CircularProgressIndicator();
    }
    if (state2 is DbSuccessState) {
      allGoals.addAll(state2.availableSavingsGoals);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('you have been successfully logged out'),
      //   behavior: SnackBarBehavior.floating,
      //    duration: Duration(seconds: 2),
      // ));
    }
    if (state2 is DbErrorState) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ErrorPage()));
    }
  }

  ///called on logout action
  onLogOut() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to log out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                log('pressing logout', name: 'admin');
                context
                    .read<AuthenticationBloc>()
                    .add(LogoutEvent(uid: user?.uid ?? '0'));
              },
            ),
          ],
        );
      },
    );
  }

  ///navigates to add page
  gotoAdd() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddSavingsGoalPage(this)));
  }

  onTap() async {
    date = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101)))!;

    //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(date);

    setState(() {
      proposedEndDateController.text =
          formattedDate; //setting output date to TextField value.
    });
  }

  Widget buildGroupSeparatorFoeExpense(Expenses groupItem) {
    // Build the header for each group (i.e., date)
    DateTime date = groupItem.date; // Get the timestamp from the group item
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[300],
      child: Text(
        '${date.year}-${date.month}-${date.day}',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildTransactionList() {
    // Group the transactions by date
    Map<DateTime, List<SavingsTransactions>> groupedTransactions = {};
    for (var transaction in allTransactions) {
      final date = DateTime(transaction.timeStamp.year,
          transaction.timeStamp.month, transaction.timeStamp.day);
      groupedTransactions.putIfAbsent(date, () => []).add(transaction);
    }
    // Create the list view builder for grouped transactions
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is DbSuccessState &&
            state.availableSavingsTransactions != null &&
            state.availableSavingsTransactions!.isNotEmpty) {
          return StickyGroupedListView<SavingsTransactions, DateTime>(
            elements: state.availableSavingsTransactions!,
            shrinkWrap: true,
            order: StickyGroupedListOrder.DESC,
            groupBy: (transaction) => DateTime(transaction.timeStamp.year,
                transaction.timeStamp.month, transaction.timeStamp.day),
            groupComparator: (date1, date2) =>
                date2.compareTo(date1), // For DESC order
            itemBuilder: (context, transaction) {
              // SavingsGoals goal = state.availableSavingsGoals
              //     .lasttWhere((element) => element.id == transaction.savingsId);
              // String title = goal.goalNotes ?? '';
              return ListTile(
                trailing: transaction.amountExpended == 0
                    ? const Text('credit')
                    : const Text(
                        'debit'), //title), // Change to the appropriate title property
                leading: transaction.amountExpended == 0
                    ? Text(
                        'Amount Saved: \$${formatDoubleWithComma(transaction.amountSaved!)}')
                    : Text(
                        'Amount Withdrawn: \$${formatDoubleWithComma(transaction.amountExpended!)}'),
                // Add other details as needed
              );
            },
            groupSeparatorBuilder: buildGroupSeparator,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildExpensesList() {
    // Group the transactions by date
    Map<DateTime, List<Expenses>> groupedExpenses = {};
    for (var expense in allExpenses) {
      final date =
          DateTime(expense.date.year, expense.date.month, expense.date.day);
      groupedExpenses.putIfAbsent(date, () => []).add(expense);
    }
    // Create the list view builder for grouped transactions
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is DbSuccessState &&
            state.availableExpenses != null &&
            state.availableExpenses!.isNotEmpty) {
          return StickyGroupedListView<Expenses, DateTime>(
            elements: state.availableExpenses!,
            shrinkWrap: true,
            order: StickyGroupedListOrder.DESC,
            groupBy: (expense) => DateTime(
                expense.date.year, expense.date.month, expense.date.day),
            groupComparator: (date1, date2) =>
                date2.compareTo(date1), // For DESC order
            itemBuilder: (context, expense) {
              SavingsGoals goal = state.availableSavingsGoals
                  .firstWhere((element) => element.id == expense.savingsId);
              String title = goal.goalNotes ?? '';
              return ListTile(
                title: Text(
                    'expense for $title'), //title), // Change to the appropriate title property
                subtitle: Text(
                    'Amount Spent: \$${formatDoubleWithComma(expense.amountSpent)}'),
                // Add other details as needed
              );
            },
            groupSeparatorBuilder: buildGroupSeparatorFoeExpense,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildGroupSeparator(SavingsTransactions groupItem) {
    // Build the header for each group (i.e., date)
    DateTime date =
        groupItem.timeStamp; // Get the timestamp from the group item
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[300],
      child: Text(
        '${date.year}-${date.month}-${date.day}',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => HomePage(
        this,
      );
  changeTab(value) {
    setState(() {
      currentIndex = value;
    });
  }
}
