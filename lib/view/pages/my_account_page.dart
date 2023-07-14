import 'package:easysave/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';

class MyAccountPage extends StatelessView<Home, HomePageController> {
  const MyAccountPage(HomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        body: body(context));
  }

  Widget body(context) {
    return const SingleChildScrollView();
  }
}
