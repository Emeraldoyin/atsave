import 'package:easysave/bloc_folder/auth_bloc/authentication_bloc.dart';
import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/view/pages/my_expenses_page.dart';
import 'package:easysave/view/pages/my_goals_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import 'add_savings_goal_page.dart';

class DashBoardPage extends StatelessView<Home, HomePageController> {
  const DashBoardPage(HomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (context, state) {
            controller.secondListener(state);
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state2) {
            controller.firstListener(state2);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            // isScrollable: true,
            indicatorColor: HEADING_COLOR1,
            labelStyle: const TextStyle(color: HEADING_COLOR1),
            indicatorSize: TabBarIndicatorSize.label,
            controller: controller.tabController,
            tabs: const [
              Tab(
                child: Text(
                  'My Goals',
                  style: TextStyle(color: HEADING_COLOR1),
                ),
              ),
              Tab(
                child: Text(
                  'My Expenses',
                  style: TextStyle(color: HEADING_COLOR1),
                ),
              ),
            ],
          ),
          actions: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state2) {
                return IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    controller.onLogOut();
                  },
                );
              },
            ),
          ],
          title: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: const Text('Dashboard'),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 70.h,
          width: 70.w,
          child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddSavingsGoalPage(controller)));
              },
              child: const Icon(Icons.add)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: TabBarView(
          controller: controller.tabController,
          children: [MyGoalsPage(controller), MyExpensesPage(controller)],
        ),
      ),
    );
  }
}
