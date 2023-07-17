import 'package:easysave/controller/signup/success_controller.dart';
import 'package:easysave/utils/helpers/design_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../consts/app_colors.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';

class SuccessPage extends StatelessView<Success, SuccessController> {
  const SuccessPage(SuccessController controller,
      {Key? key,
      required this.succcessful,
      required this.displayMessage,
      required this.displayImageURL,
      required this.buttonText,
      required this.displaySubText,
      required this.destination})
      : super(controller, key: key);
  final bool succcessful;
  final String displayMessage;
  final String displaySubText;
  final String displayImageURL;
  final String buttonText;
  final Widget destination;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: BACKGROUND_COLOR2,
      //   title: CircleAvatar(child: Image.asset('assets/images/logo.png'))
      // ),
      backgroundColor: BACKGROUND_COLOR1,
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            // top: size.height / 0,
            //left: size.width / 11,
            //right: size.width / 11,
            //top: 150.h,
            child: Image.asset(
              displayImageURL,
              width: size.width,
              height: size.height,
              fit: BoxFit.contain,
            ),
          ),
          Center(
              child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.darken,
              color: Colors.black.withOpacity(0.2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                  child: Text(displayMessage,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
                addVerticalSpace(20),
                Text(displaySubText,
                    style: Theme.of(context).textTheme.displayMedium),
                addVerticalSpace(32),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => destination));
                    },
                    child: Text(buttonText)),
              ],
            ),
          )),
          Positioned(
            top: 680,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: RadialGradient(radius: 5, colors: [
                APPBAR_COLOR2,
                APPBAR_COLOR1,
                Colors.white,
                APPBAR_ICON_COLOR
              ])),
              child: TypeWriterText(
                repeat: true,
                play: true,
                alignment: Alignment.topCenter,
                text: Text(
                    'ATSave... Your number one mobile app for tracking and managing your savings goals. Saving your money just got a lot easier. You are a click away from experiencing the real deal. Let\'s get started!',
                    style: Theme.of(context).textTheme.displayMedium),
                duration: const Duration(milliseconds: 50),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
