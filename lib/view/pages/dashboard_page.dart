import 'package:easysave/bloc_folder/auth_bloc/authentication_bloc.dart';
import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/view/pages/my_goals_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';

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
              // Tab(
              //   child: Text(
              //     'My Accounts',
              //     style: TextStyle(color: HEADING_COLOR1),
              //   ),
              // ),
            ],
          ),

          actions: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state2) {
                return
                    // AvatarGlow(
                    //   glowColor:
                    //       APPBAR_COLOR2, // Change this to your desired glow color
                    //   endRadius: 80.0,
                    //   duration: const Duration(milliseconds: 2000),
                    //   repeat: true,
                    //   showTwoGlows: true,
                    //   repeatPauseDuration: const Duration(milliseconds: 100),
                    //   child: Material(
                    //     elevation: 8.0,
                    //     shape: const CircleBorder(),
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.grey[100],
                    //       radius: 30.0,
                    //       child: Text(
                    //         getInitials(controller.user!.displayName!),
                    //         style: const TextStyle(fontSize: 20.0),
                    //       ),
                    //     ),
                    //   ),
                    // );
                    IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    controller.onLogOut();
                  },
                );
              },
            ),
          ],
          //leading: CircleAvatar()
          title: const Text('Dashboard'),
        ),
        drawer: const DropdownMenu(
          menuStyle: MenuStyle(),
          dropdownMenuEntries: [],
        ),

        // drawer: const DropdownMenu(dropdownMenuEntries: []),
        body:
            //const SafeArea(
            //     child: Column(
            //   children: [Card(), Text('this is dashboard')],
            // )),
            TabBarView(
          controller: controller.tabController,
          children: [
            MyGoalsPage(controller),
            const Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
