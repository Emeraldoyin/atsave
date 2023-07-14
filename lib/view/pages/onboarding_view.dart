import 'package:easysave/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/consts/app_texts.dart';
import '/controller/onboarding/onboarding_controller.dart';
import '/utils/helpers/boilerplate/stateless_view.dart';
import '/view/widgets/dot_container.dart';

class OnboardingView extends StatelessView<Onboarding, OnboardingController> {
  const OnboardingView(OnboardingController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [ONBOARD_COLOR, BACKGROUND_COLOR1],
            begin: AlignmentDirectional.topStart,
            end: FractionalOffset.bottomCenter),
      ),
      child: Stack(
        children: [
          //  SizedBox(height: 580.h),

          Padding(
            padding: EdgeInsets.fromLTRB(90.w, 425.43.h, 92.w, 61.h),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    sliderList.length,
                    (index) =>
                        dotContainer(index, context, controller.currentIndex)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(86.w, 127.h, 72.w, 61.h),
            child: PageView.builder(
                controller: controller.onboardCtrl,
                itemCount: sliderList.length,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) => controller.changePage(value),
                itemBuilder: (context, index) {
                  return sliderList[index];
                }),
          ),

          controller.currentIndex == 0
              ? nextButton(
                  controller: controller,
                  leftPadding: 200.w,
                  rightPadding: 37.w,
                )
              : controller.onboardLastpage
                  ? Row(
                      children: [
                        previousButton(controller: controller),
                        finishButton(controller: controller),
                      ],
                    )
                  : Row(
                      children: [
                        previousButton(controller: controller),
                        //addHorizontalSpace(60),
                        nextButton(
                            controller: controller,
                            leftPadding: 100.w,
                            rightPadding: 5.w)
                      ],
                    )
        ],
      ),
    ));
  }
}

class finishButton extends StatelessWidget {
  const finishButton({
    super.key,
    required this.controller,
  });

  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(top: 580.h, left: 100.w, bottom: 69.h, right: 5.w),
        child: ElevatedButton(
          child: const Text(
            'Get Started',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () => controller.goToSignInPage(),
        ));
  }
}

class previousButton extends StatelessWidget {
  const previousButton({super.key, required this.controller});
  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 580.h, left: 36.h, bottom: 69.h),
      child: InkWell(
        onTap: () {
          controller.onPreviousClick();
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: BUTTON_COLOR1,
              size: 12,
            ),
            // addHorizontalSpace(10.w),
            Text(
              'Previous',
              style: TextStyle(color: BUTTON_COLOR1),
            )
          ],
        ),
      ),
    );
  }
}

class nextButton extends StatelessWidget {
  const nextButton(
      {super.key,
      required this.controller,
      required this.leftPadding,
      required this.rightPadding});

  final OnboardingController controller;
  final double leftPadding;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 580.h, left: leftPadding, bottom: 69.h, right: rightPadding),
      child: ElevatedButton(
        onPressed: () {
          controller.onNextClick();
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Next',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
