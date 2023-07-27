import 'package:easysave/view/pages/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';

class TransactionsPage extends StatelessView<Home, HomePageController> {
  const TransactionsPage(HomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: const Text('Transactions'),
          ),
        ),
        body: body(context));
  }

  Widget body(context) {
    return Scaffold(
      body: MyGoals(
          username: controller.user!.displayName,
          controller: controller,
          allGoals: controller.allGoals),
    );
  }
}
