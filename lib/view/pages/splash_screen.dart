import 'package:easysave/consts/app_colors.dart';
import 'package:flutter/material.dart';

import '/controller/splash_screen/splash_controller.dart';
import '/utils/helpers/boilerplate/stateless_view.dart';

class SplashScreen extends StatelessView<Splash, SplashController> {
  const SplashScreen(SplashController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ONBOARD_COLOR,
      body: Center(child: Image.asset('assets/images/logo.png')),
    );
  }
}
