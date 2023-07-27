import 'package:easysave/config/theme/app_theme.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/view/pages/add_transaction.dart';
import 'package:easysave/view/pages/dashboard_page.dart';
import 'package:easysave/view/pages/transactions_page.dart';
import 'package:easysave/view/pages/wallet_page.dart';
import 'package:flutter/material.dart';

import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';

class HomePage extends StatelessView<Home, HomePageController> {
  const HomePage(HomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
      // floatingActionButton: SizedBox(
      //   height: 70.h,
      //   width: 70.w,
      //   child: FloatingActionButton(
      //       onPressed: () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => AddSavingsGoalPage(controller)));
      //       },
      //       child: const Icon(Icons.add)),
      // ),
      //  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        useLegacyColorScheme: false,
        onTap: (value) => controller.changeTab(value),
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        showSelectedLabels: true,
        unselectedItemColor: SUBTEXT_COLOR,
        selectedItemColor: Colors.white,
        items: [
          controller.navbar(
            icon: Icons.dashboard,
            label: 'Dashboard',
          ),

          // controller.navbar(
          //   icon: Icons.attach_money,
          //   label: 'Add',
          // ),
          controller.navbar(
            icon: Icons.account_balance_wallet,
            label: 'Wallet',
          ),
          controller.navbar(
            icon: Icons.add_to_home_screen,
            label: 'add',
          ),
          controller.navbar(
            icon: Icons.inventory_rounded,
            label: 'Transactions',
          ),
          //  controller.navbar(icon: Icons.more, label: 'More'),
        ],
        currentIndex: controller.currentIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget body(context) {
    return Center(
      child: IndexedStack(
        index: controller.currentIndex,
        children: [
          DashBoardPage(controller),
          const WalletPage(),
          AddTransactionsPage(controller),
          TransactionsPage(controller),
          // const MorePage()
        ],
      ),
    );
  }
}
