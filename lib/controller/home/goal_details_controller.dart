import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/model/savings_transactions.dart';
import 'package:easysave/view/pages/edit_savings_goals_page.dart';
import 'package:easysave/view/pages/goal_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc_folder/database_bloc/database_bloc.dart';
import '../../bloc_folder/db_connectivity/connectivity_bloc.dart';
import '../../consts/app_colors.dart';
import '../../model/category.dart';
import '../signup/success_controller.dart';
import 'home_controller.dart';

class GoalDetails extends StatefulWidget {
  //static const routeName = Strings.SCREEN_GoalDetails;
  final SavingsGoals goal;
  const GoalDetails({Key? key, required this.goal}) : super(key: key);

  @override
  GoalDetailsController createState() => GoalDetailsController();
}

class GoalDetailsController extends State<GoalDetails> {
  //... //Initialization code, state vars etc, all go here
  TextEditingController targetAmountController = TextEditingController();
  TextEditingController goalNotesController = TextEditingController();
  TextEditingController currentAmountController = TextEditingController();
  TextEditingController proposedEndDateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final editGoalFormKey = GlobalKey<FormState>();
  late DateTime date;
  String? selectedCategory;

  @override
  void initState() {
    context.read<ConnectivityBloc>().add(RetrieveDataEvent(uid: user!.uid));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int calculateDaysLeft(DateTime goalCompletionDate) {
    DateTime now = DateTime.now();
    Duration difference = goalCompletionDate.difference(now);
    int daysLeft = difference.inDays;
    return daysLeft;
  }

  String? validate(value) {
    if (value.isEmpty) {
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

  List<DropdownMenuItem<String>> dropdownItems = categoryList.map((category) {
    return DropdownMenuItem<String>(
      value: category.name,
      child: Text(category.name),
    );
  }).toList();

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
    var splitted = targetAmountController.text.split(',');
    var splitted2 = currentAmountController.text.split(',');

    double targetAmount = double.parse(splitted.join());

    double currentAmount = double.parse(splitted2.join());
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
            uid: user!.uid,
            targetAmount: targetAmount,
            categoryId: categoryList
                .indexWhere((element) => element.name == selectedCategory),
            currentAmount: currentAmount,
            endDate: dateTime,
            progressPercentage:
                double.parse(progressPercentage.toStringAsFixed(2)),
            goalNotes: goalNotesController.text);

        SavingsTransactions newTxn = SavingsTransactions(amountExpended: 0, amountSaved: double.parse(currentAmountController.text), savingsId: newlyAddedGoal.id!, uid: user!.uid, timeStamp: DateTime.now(), );
        context.read<DatabaseBloc>().add(EditGoalsEvent(goal: newlyAddedGoal, txn:newTxn));
        
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Success(
                      buttonText: 'Done',
                      displayImageURL: 'assets/images/money and phone.png',
                      displayMessage: 'Congratulations!!!',
                      succcessful: true,
                      displaySubText: 'You just added a new savings goals.',
                      destination: Home(),
                    )));
      }
    }
  }

  @override
  Widget build(BuildContext context) => GoalDetailsPage(this, widget.goal);
}
