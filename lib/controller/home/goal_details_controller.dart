import 'package:easysave/model/savings_goals.dart';
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

class GoalDetails extends StatefulWidget {
  //static const routeName = Strings.SCREEN_GoalDetails;
  final SavingsGoals goal;
  final List<Category> categories;
  const GoalDetails({Key? key, required this.goal, required this.categories})
      : super(key: key);

  @override
  GoalDetailsController createState() => GoalDetailsController();
}

class GoalDetailsController extends State<GoalDetails> {
  //... //Initialization code, state vars etc, all go here
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

  final addAmountFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    targetAmountController.text = widget.goal.targetAmount.toString();
    goalNotesController.text = widget.goal.goalNotes!;
    currentAmountController.text = widget.goal.currentAmount.toString();
    proposedEndDateController.text = formatDateTime(widget.goal.endDate);
    newAmountController.text = widget.goal.currentAmount.toString();
    // context.read<ConnectivityBloc>().add(RetrieveDataEvent(uid: user!.uid));
    super.initState();
    // log(pinnedGoals.toString(), name: 'pinnedGoals');
  }

  @override
  void dispose() {
    super.dispose();
  }

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

  int calculateDaysLeft(DateTime goalCompletionDate) {
    DateTime now = DateTime.now();
    Duration difference = goalCompletionDate.difference(now);
    int daysLeft = difference.inDays;
    return daysLeft;
  }

  String? validate(value) {
    if (value == null) {
      return 'Field cannot be empty';
    } else {
      return null;
    }
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

  onCategoryClicked(value) {
    setState(() {
      selectedCategory = value;
    });
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

  onClickEdit() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditSavingsGoalPage(this, widget.goal)));
  }

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

        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Success(
                      buttonText: 'Done',
                      displayImageURL: 'assets/images/credit cards.png',
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

  onEditCurrentAmount(double amount, double amountRemaining) {
    widget.goal.currentAmount +
        parseStringToDouble(currentAmountController.text);
    setState(() {});
    context
        .read<ConnectivityBloc>()
        .add(UpdateCurrentAmountEvent(goal: widget.goal, addedAmount: amount));
  }

  @override
  Widget build(BuildContext context) =>
      GoalDetailsPage(this, widget.goal, widget.categories);
}
