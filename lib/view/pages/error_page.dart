import 'package:easysave/utils/helpers/design_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/signin/signin_controller.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('budget'), automaticallyImplyLeading: false,),
      body: SizedBox(
        // decoration: const BoxDecoration(color: BACKGROUND_COLOR2),
        child: Center(
          child: Container(
              height: double.infinity,
              width: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.center,
                      image: AssetImage('assets/images/error.png'))),
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        'Ooops! Something went wrong and I think you should check your internet.\nSorry...',
                        style: Theme.of(context).textTheme.displayMedium),
                    addVerticalSpace(20),
                    Padding(
                      padding: EdgeInsets.only(right: 140.w),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignIn()));
                          },
                          child: const Row(
                            children: [
                              Text('Go Back'),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          )),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
