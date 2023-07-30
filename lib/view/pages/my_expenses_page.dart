import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/config/theme/app_theme.dart';
import 'package:easysave/consts/app_images.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/view/widgets/major_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_margin_widget/flutter_margin_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';

class MyExpensesPage extends StatelessView<Home, HomePageController> {
  const MyExpensesPage(HomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        body: body(context));
  }

  Widget body(context) {
    return Scaffold(
      body: MyExpenses(
          username: controller.user!.displayName,
          controller: controller,
          allGoals: controller.allGoals),
    );
  }
}

class MyExpenses extends StatelessWidget {
  const MyExpenses({
    super.key,
    required this.username,
    required this.controller,
    required this.allGoals,
  });

  final String? username;
  final HomePageController controller;
  final List<SavingsGoals?> allGoals;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is DbSuccessState &&
            state.availableExpenses!.isEmpty &&
            state.availableExpenses != null) {
          SingleChildScrollView(
            child: SafeArea(
              child: Margin(
                margin: EdgeInsets.all(8.r),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MajorCard(
                        controller: controller,
                        username: username,
                        actionWord:
                            'You do not have any expenses yet. Start by saving some money',
                      ),
                    ),
                    SizedBox(
                      child: Image.asset(image2),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        if (state is DbSuccessState &&
            state.availableExpenses!.isNotEmpty &&
            state.availableExpenses != null) {
          return SingleChildScrollView(
            child: controller.buildExpensesList(),
          );
        }
        return SingleChildScrollView(
          child: SafeArea(
            child: Margin(
              margin: EdgeInsets.all(8.r),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MajorCard(
                      controller: controller,
                      username: username,
                      actionWord: 'You do not have any expenses yet.',
                    ),
                  ),
                  SizedBox(
                    child: Image.asset(image2),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
