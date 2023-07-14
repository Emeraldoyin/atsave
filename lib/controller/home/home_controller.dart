import 'package:easysave/bloc_folder/database_bloc/database_bloc.dart';
import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/controller/signup/success_controller.dart';
import 'package:easysave/model/category.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/view/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../model/expenses.dart';
import '../../utils/helpers/session_manager.dart';

class Home extends StatefulWidget {
  //static const routeName = Strings.SCREEN_BLANK;

  const Home({Key? key}) : super(key: key);

  @override
  HomePageController createState() => HomePageController();
}

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

class HomePageController extends State<Home>
    with SingleTickerProviderStateMixin {
  //... //Initialization code, state vars etc, all go here
  int currentIndex = 0;
  final addGoalFormKey = GlobalKey<FormState>();
  TabController? controller;
  int selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser;
  String? username;
  late DateTime date;
  List<SavingsGoals> allGoals = [];
  SavingsGoals? newlyAddedGoal;
  RegExp decimalRegex = RegExp(r'^-?\d+\.?\d*$');

  List<Expenses> getExpenses() {
    final List<Expenses> expenses = [
      // Expenses(amountSpent: 20000, date: 'August', color: Colors.blue),
      // Expenses(amountSpent: 20000, date: 'September', color: Colors.pink),
      // Expenses(amountSpent: 10, date: 'May', color: Colors.orange),
      // Expenses(amountSpent: 20000, date: 'June', color: Colors.green),
      // Expenses(amountSpent: 20000, date: 'January', color: Colors.yellow),
    ];
    return expenses;
  }

  TextEditingController targetAmountController = TextEditingController();
  TextEditingController goalNotesController = TextEditingController();
  TextEditingController startAmountController = TextEditingController();
  TextEditingController proposedEndDateController = TextEditingController();
  String? selectedCategory;

  List<DropdownMenuItem<String>> dropdownItems = categoryList.map((category) {
    return DropdownMenuItem<String>(
      value: category.name,
      child: Text(category.name),
    );
  }).toList();

  onCategoryClicked(value) {
    setState(() {
      selectedCategory = value;
    });
  }

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
        color: value == currentIndex ? Colors.white : Colors.grey,
      ),
      label: label,
    );
  }

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    context.read<ConnectivityBloc>().add(RetrieveDataEvent());
    controller = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SessionManager manager = SessionManager();
      manager.hasUserAddedGoal(false);
    });
    // SavingsGoals(categoryId: int.parse(selectedCategory), targetAmount: targetAmountController., String? goalNotes, required int categoryId, required double startAmount, required DateTime endDate, required double progressPercentage)
  }

  String? getUsername() {
    username = user!.displayName;
    return username;
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  onClick() {
    controller!.animateTo(selectedIndex += 1);
  }


  String? validate(value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    } else {
      return null;
    }
  }

  onSaveGoal(key) async {
    if(key.currentState.validate){
       double goal = double.parse(targetAmountController.text);
    double startingAmount = double.parse(startAmountController.text);
    double progressPercentage = startingAmount / goal * 100;
    SavingsGoals newlyAddedGoal = SavingsGoals(
        uid: user!.uid,
        targetAmount: goal,
        categoryId: categoryList
            .indexWhere((element) => element.name == selectedCategory),
        startAmount: startingAmount,
        endDate: date,
        progressPercentage: progressPercentage,
        goalNotes: goalNotesController.text);
    if (addGoalFormKey.currentState!.validate()) {
      context
          .read<DatabaseBloc>()
          .add(AddSavingsGoalsEvent(goal: newlyAddedGoal));
      allGoals.add(newlyAddedGoal);
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
          formattedDate; //set output date to TextField value.
    });
  }

  @override
  Widget build(BuildContext context) => HomePage(this);
  changeTab(value) {
    setState(() {
      currentIndex = value;
    });
  }
}
