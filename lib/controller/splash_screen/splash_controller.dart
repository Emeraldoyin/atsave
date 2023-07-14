import 'package:easysave/controller/onboarding/onboarding_controller.dart';
import 'package:easysave/controller/signin/signin_controller.dart';
import 'package:easysave/view/pages/splash_screen.dart';
import 'package:flutter/material.dart';

import '/utils/helpers/session_manager.dart';
import '../home/home_controller.dart';

class Splash extends StatefulWidget {

  const Splash({Key? key}) : super(key: key);

  @override
  SplashController createState() => SplashController();
}

class SplashController extends State<Splash> {
  

  @override
  void initState() {
    super.initState();

    isLoading();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SplashScreen(this);

  isLoading() async {
    Future.delayed(const Duration(seconds: 10), () async {
      SessionManager manager = SessionManager();
      bool? hasUserSeenOnboardingPage = await manager.seenOnboardingScreen();
      bool? loggedIn = await manager.isUserLoggedIn();
      if (hasUserSeenOnboardingPage != null &&
          hasUserSeenOnboardingPage &&
          loggedIn != true) {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
      } else if (hasUserSeenOnboardingPage != null &&
          hasUserSeenOnboardingPage &&
          loggedIn != null &&
          loggedIn) {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Onboarding()));
      }
    });
  }
}
