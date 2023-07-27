import 'dart:developer';

import 'package:easysave/bloc_folder/auth_bloc/authentication_bloc.dart';
import 'package:easysave/bloc_folder/database_bloc/database_bloc.dart';
import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/controller/signup/success_controller.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/utils/helpers/double_parser.dart';
import 'package:easysave/view/pages/add_savings_goal_page.dart';
import 'package:easysave/view/pages/error_page.dart';
import 'package:easysave/view/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../model/category.dart';
import '../../utils/helpers/session_manager.dart';
import '../signin/signin_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.categories}) : super(key: key);
  final List<Category>? categories;
  @override
  HomePageController createState() => HomePageController();
}

List<Category> categoryList = [
  Category(name: 'Food', imagePath: 'assets/images/food.jpeg'),
  Category(name: 'Auto & Gas', imagePath: 'assets/images/car.jpeg'),
  Category(name: 'Events', imagePath: 'assets/images/events.jpeg'),
  Category(name: 'Family Needs', imagePath: 'assets/images/family.jpeg'),
  Category(name: 'Apartment', imagePath: 'assets/images/apartment.jpeg'),
  Category(name: 'Utility Bills', imagePath: 'assets/images/bills.jpeg'),
  Category(name: 'Travels', imagePath: 'assets/images/travels.jpeg'),
  Category(name: 'Books', imagePath: ''),
  Category(
      name: 'Non-specified',
      imagePath: 'assets/images/open home_safe_with_money.png'),
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
  TextEditingController targetAmountController = TextEditingController();
  TextEditingController goalNotesController = TextEditingController();
  TextEditingController startAmountController = TextEditingController();
  TextEditingController proposedEndDateController = TextEditingController();

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
        SavingsGoals newlyAddedGoal = SavingsGoals(
            uid: user!.uid,
            targetAmount: targetAmount,
            categoryId: categoryList
                .indexWhere((element) => element.name == selectedCategory),
            currentAmount: startingAmount,
            endDate: dateTime,
            progressPercentage:
                double.parse(progressPercentage.toStringAsFixed(2)),
            goalNotes: goalNotesController.text);

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

  onLogOut() {
    log('pressing logout', name: 'admin');
    context.read<AuthenticationBloc>().add(LogoutEvent(uid: user!.uid));
  }

  gotoAdd() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddSavingsGoalPage(this)));
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
  Widget build(BuildContext context) => HomePage(
        this,
      );
  changeTab(value) {
    setState(() {
      currentIndex = value;
    });
  }
}
