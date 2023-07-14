import 'package:flutter/material.dart';

import '/utils/helpers/session_manager.dart';
import '/view/pages/onboarding_view.dart';
import '../signin/signin_controller.dart';

class Onboarding extends StatefulWidget {
  //static const routeName = Strings.SCREEN_BLANK;

  const Onboarding({Key? key}) : super(key: key);

  @override
  OnboardingController createState() => OnboardingController();
}

class OnboardingController extends State<Onboarding> {
  //... //Initialization code, state vars etc, all go here

  PageController onboardCtrl = PageController();
  bool onboardLastpage = false;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SessionManager manager = SessionManager();
      manager.saveIfUserHasSeenOnboardingScreen(true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    onboardCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) => OnboardingView(this);

  changePage(value) {
    setState(() {
      currentIndex = value;
      onboardLastpage = value == 3;
    });
  }

  goToSignInPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SignIn(),
    ));
  }

  onPreviousClick() {
    setState(() {
      if (currentIndex >= 1 && currentIndex < 4) {
        currentIndex--;

        onboardCtrl.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  onNextClick() {
    setState(() {
      if (currentIndex <= 2) {
        currentIndex++;

        onboardCtrl.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }
}
