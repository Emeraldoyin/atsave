import 'package:easysave/config/theme/app_theme.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/view/pages/dashboard_page.dart';
import 'package:easysave/view/pages/transactions_page.dart';
import 'package:easysave/view/pages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import 'add_savings_goal_page.dart';

class HomePage extends StatelessView<Home, HomePageController> {
  const HomePage(HomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
      
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
          controller.navbar(
            icon: Icons.account_balance_wallet,
            label: 'Wallet',
          ),
          controller.navbar(
            icon: Icons.monetization_on_outlined,
            label: 'Transactions',
          ),
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
          WalletPage(controller),
          TransactionsPage(controller),
        ],
      ),
    );
  }
}
