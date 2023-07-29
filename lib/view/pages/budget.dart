import 'package:easysave/consts/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('budget')),
      body: SingleChildScrollView(
        // decoration: const BoxDecoration(color: BACKGROUND_COLOR2),
        child: Column(
          children: [
            Container(
                height: 500.h,
                width: 500.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image18))),
                child: const Text('this is Budget page')),
          ],
        ),
      ),
    );
  }
}
