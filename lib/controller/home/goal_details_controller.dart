import 'package:easysave/consts/app_images.dart';
import 'package:easysave/model/expenses.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/utils/helpers/comma_formatter.dart';
import 'package:easysave/utils/helpers/date_formatter.dart';
import 'package:easysave/view/pages/edit_savings_goals_page.dart';
import 'package:easysave/view/pages/goal_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc_folder/db_connectivity/connectivity_bloc.dart';
import '../../consts/app_colors.dart';
import '../../model/category.dart';
import '../../model/savings_transactions.dart';
import '../../utils/helpers/double_parser.dart';
import '../signup/success_controller.dart';
import 'home_controller.dart';

///This is the controller class for the goal details screen
class GoalDetails extends StatefulWidget {
  final SavingsGoals goal;
  final List<Category> categories;
  const GoalDetails({Key? key, required this.goal, required this.categories})
      : super(key: key);

  @override
  GoalDetailsController createState() => GoalDetailsController();
}

class GoalDetailsController extends State<GoalDetails> {
  //... //Initialization code, state vars etc
  TextEditingController targetAmountController = TextEditingController();
  TextEditingController goalNotesController = TextEditingController();
  TextEditingController currentAmountController = TextEditingController();
  TextEditingController proposedEndDateController = TextEditingController();
  TextEditingController newAmountController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final editGoalFormKey = GlobalKey<FormState>();
  late DateTime date;
  String? selectedCategory;
  List<SavingsGoals?> pinnedGoals = [];

  TextEditingController spentAmountController = TextEditingController();

  final addAmountFormKey = GlobalKey<FormState>();
  final spendAmountFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    targetAmountController.text =
        formatDoubleWithComma(widget.goal.targetAmount);
    goalNotesController.text = widget.goal.goalNotes!;
    currentAmountController.text =
        formatDoubleWithComma(widget.goal.currentAmount);
    proposedEndDateController.text = formatDateTime(widget.goal.endDate);
    newAmountController.text = formatDoubleWithComma(widget.goal.currentAmount);
    // context.read<ConnectivityBloc>().add(RetrieveDataEvent(uid: user!.uid));
    super.initState();
    // log(pinnedGoals.toString(), name: 'pinnedGoals');
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///this method is called when a savings goal is pinned
  void onPinGoal(SavingsGoals goal) {
    setState(() {
      if (pinnedGoals.contains(goal)) {
        pinnedGoals.remove(goal);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Goal unpinned.'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          backgroundColor: APPBAR_COLOR2,
        ));
      } else {
        pinnedGoals.add(goal);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Goal pinned'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          backgroundColor: APPBAR_COLOR2,
        ));
      }
    });
    // log(pinnedGoals.toString(), name: 'pinnedGoals');
  }

  ///used to calculate the number of days left to the completion date
  int calculateDaysLeft(DateTime goalCompletionDate) {
    DateTime now = DateTime.now();
    Duration difference = goalCompletionDate.difference(now);
    int daysLeft = difference.inDays;
    return daysLeft;
  }

  ///for validating text field
  String? validate(value) {
    if (value == null) {
      return 'Field cannot be empty';
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

  ///function for displaying the date picker
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

  ///sets selected category as value of dropdown items
  onCategoryClicked(value) {
    setState(() {
      selectedCategory = value;
    });
  }

  ///to validate that value of amount is not zero
  String? validateAmount(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    } else if (value == 0) {
      return 'Invalid amount to save';
    } else {
      return null;
    }
  }

  ///action handler on clicking edit button in details page
  onClickEdit() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditSavingsGoalPage(this, widget.goal)));
  }

  ///method that handles the bloc event that happens on edit
  onEditGoal() async {
    String inputText = proposedEndDateController.text;
    DateFormat inputFormat = DateFormat("EEEE, MMM d, y");
    DateTime dateTime = inputFormat.parse(inputText);

    double targetAmount = parseStringToDouble(targetAmountController.text);

    double currentAmount = parseStringToDouble(currentAmountController.text);
    double progressPercentage = currentAmount / targetAmount * 100;
    if (currentAmount > targetAmount) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'The amount you\'re saving now should be less the target amount.'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        backgroundColor: APPBAR_COLOR2,
      ));
    } else {
      if (editGoalFormKey.currentState!.validate()) {
        ///creating a savingsgoal instance that will be used to update the former one in local database
        SavingsGoals newlyAddedGoal = SavingsGoals(
            id: widget.goal.id,
            uid: user!.uid,
            targetAmount: targetAmount,
            categoryId: widget.categories
                .indexWhere((element) => element.name == selectedCategory),
            currentAmount: currentAmount,
            endDate: dateTime,
            progressPercentage:
                double.parse(progressPercentage.toStringAsFixed(2)),
            goalNotes: goalNotesController.text);
        print(newlyAddedGoal.toString());

        ///creating a new [SavingsTransactions] instance to be saved after goal is edited
        SavingsTransactions newTxn = SavingsTransactions(
          amountExpended: 0,
          amountSaved: newlyAddedGoal.currentAmount,
          savingsId: newlyAddedGoal.id!,
          uid: user!.uid,
          timeStamp: DateTime.now(),
        );
        context
            .read<ConnectivityBloc>()
            .add(EditGoalEvent(goal: newlyAddedGoal, txn: newTxn));

        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Success(
                      buttonText: 'Done',
                      displayImageURL: image5,
                      displayMessage: 'Goal updated successfully.',
                      succcessful: true,
                      amount: currentAmountController.text,
                      displaySubText: 'Keep saving!.',
                      destination: Home(
                        categories: widget.categories,
                      ),
                    )));
        //log(amount, name: 'amount text');
      }
    }
  }

  ///called when user clicks the withdraw button. calls bloc to add expenses and deduct from savings
  onWithdraw(double amountExpended) {
    widget.goal.currentAmount -
        parseStringToDouble(currentAmountController.text);
    setState(() {});
    Expenses newExpense = Expenses(
        amountSpent: amountExpended,
        date: DateTime.now(),
        savingsId: widget.goal.id!,
        uid: user!.uid);

    SavingsTransactions newtxn = SavingsTransactions(
        amountExpended: amountExpended,
        amountSaved: 0,
        savingsId: widget.goal.id,
        timeStamp: DateTime.now(),
        uid: user!.uid);
    context.read<ConnectivityBloc>().add(
        WithdrawEvent(goal: widget.goal, expense: newExpense, txn: newtxn));
  }

  ///method that handles the bloc event that happens when money is added to the savings goal
  onEditCurrentAmount(double amount, double amountRemaining) {
    widget.goal.currentAmount +
        parseStringToDouble(currentAmountController.text);
    setState(() {});
    SavingsTransactions newtxn = SavingsTransactions(
        amountExpended: 0,
        amountSaved: amount,
        savingsId: widget.goal.id,
        timeStamp: DateTime.now(),
        uid: user!.uid);
    context.read<ConnectivityBloc>().add(UpdateCurrentAmountEvent(
        goal: widget.goal, addedAmount: amount, txn: newtxn));
  }

  @override
  Widget build(BuildContext context) =>
      GoalDetailsPage(this, widget.goal, widget.categories);
}
