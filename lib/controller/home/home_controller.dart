import 'dart:developer';

import 'package:easysave/bloc_folder/auth_bloc/authentication_bloc.dart';
import 'package:easysave/bloc_folder/database_bloc/database_bloc.dart';
import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/controller/signup/success_controller.dart';
import 'package:easysave/model/category.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/view/pages/error_page.dart';
import 'package:easysave/view/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../model/expenses.dart';
import '../../utils/helpers/session_manager.dart';
import '../signin/signin_controller.dart';

class Home extends StatefulWidget {
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
  TabController? tabController;
  int selectedIndex = 0;
  String? selectedCategory;
  String? username;
  late DateTime date;
  List<SavingsGoals> allGoals = [];
  SavingsGoals? newlyAddedGoal;
  RegExp decimalRegex = RegExp(r'^-?\d+\.?\d*$');
  final user = FirebaseAuth.instance.currentUser;
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
      ),
      label: label,
    );
  }

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    context.read<ConnectivityBloc>().add(RetrieveDataEvent(uid: user!.uid));
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  String? getUsername() {
    username = user!.displayName;
    if (username == null) {
      return 'Unknown';
    } else {
      return username!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  onClick() {
    tabController!.animateTo(selectedIndex += 1);
  }

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

  onSaveGoal() async {
    String inputText = proposedEndDateController.text;
    DateFormat inputFormat = DateFormat("EEEE, MMM d, y");
    DateTime dateTime = inputFormat.parse(inputText);

    if (addGoalFormKey.currentState!.validate()) {
      var splitted = targetAmountController.text.split(',');
      var splitted2 = startAmountController.text.split(',');

      double saveTargetAmount = double.parse(splitted.join());

      double startingAmount = double.parse(splitted2.join());
      double progressPercentage = startingAmount / saveTargetAmount * 100;
      SavingsGoals newlyAddedGoal = SavingsGoals(
          uid: user!.uid,
          targetAmount: saveTargetAmount,
          categoryId: categoryList
              .indexWhere((element) => element.name == selectedCategory),
          startAmount: startingAmount,
          endDate: dateTime,
          progressPercentage:
              double.parse(progressPercentage.toStringAsFixed(2)),
          goalNotes: goalNotesController.text);

      if (addGoalFormKey.currentState!.validate()) {
        // allGoals.add(newlyAddedGoal);

        context
            .read<DatabaseBloc>()
            .add(AddSavingsGoalsEvent(goal: newlyAddedGoal));

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
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('you have been successfully logged out'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ));
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

  onLogOut() {
    log('pressing logout', name: 'admin');
    context.read<AuthenticationBloc>().add(LogoutEvent(uid: user!.uid));
  }

  listener(state) {
    if (state is DbLoadingState) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Waiting for network...'),
      ));
    }
    if (state is DbSuccessState) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        SessionManager manager = SessionManager();
        manager.loggedIn(false);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('you have been successfully logged out'),
        behavior: SnackBarBehavior.floating,
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignIn()));
      // try {

      // } catch (e) {
      //   showSnackBar(
      //     context,
      //     e.toString(), Colors.red
      //   );
      // }
    }
    if (state is DbErrorState) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ErrorPage()));
    }

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //       content: Text('Login Error. Kindly try again.'),
    //       backgroundColor: ICON_COLOR5),
    // );
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

  @override
  Widget build(BuildContext context) => HomePage(this);
  changeTab(value) {
    setState(() {
      currentIndex = value;
    });
  }
}
