import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/utils/helpers/logout.dart';
import 'package:easysave/view/pages/my_goals_page.dart';
import 'package:flutter/material.dart';

import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';

class DashBoardPage extends StatelessView<Home, HomePageController> {
  const DashBoardPage(HomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          // isScrollable: true,
          indicatorColor: HEADING_COLOR1,
          labelStyle: const TextStyle(color: HEADING_COLOR1),
          indicatorSize: TabBarIndicatorSize.label,
          controller: controller.controller,
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
            Tab(
              child: Text(
                'My Accounts',
                style: TextStyle(color: HEADING_COLOR1),
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              onLogout(context);
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
        controller: controller.controller,
        children: [
          myGoals(
            username: controller.getUsername(),
            controller: controller,
            allGoals: controller.allGoals,
          ),
          const Icon(Icons.directions_transit, size: 350),
          const Icon(Icons.directions_car, size: 350),
        ],
      ),
    );
  }
}
