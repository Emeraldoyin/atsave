import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../consts/app_colors.dart';
import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import '../../utils/helpers/design_helpers.dart';

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
      body: const body(),
    );
  }
}

class body extends StatelessWidget {
  const body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(38.r),
      child: Container(
          padding: EdgeInsets.all(16.0.r),
          height: 153.h,
          width: 284.w,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 1)
            ],
            color: CARD_COLOR1,
          ),
          child: SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addVerticalSpace(8.h),
                    Text('Total Savings Balance:',
                        style: Theme.of(context).textTheme.labelSmall),
                    addHorizontalSpace(
                      50.w,
                    ),
                    Text('120,000 dollars',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addVerticalSpace(8.h),
                    Text('Total Number of Wallets:',
                        style: Theme.of(context).textTheme.labelSmall),
                    addHorizontalSpace(
                      50.w,
                    ),
                    Text('10', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addVerticalSpace(8.h),
                    Text('Total Completed Goals:',
                        style: Theme.of(context).textTheme.labelSmall),
                    addHorizontalSpace(
                      50.w,
                    ),
                    Text('5', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addVerticalSpace(8.h),
                    Text('Total Expenses:',
                        style: Theme.of(context).textTheme.labelSmall),
                    addHorizontalSpace(
                      50.w,
                    ),
                    Text('50,000 dollars',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),

                //  addVerticalSpace(4.h)
              ],
            ),
          )),
    );
  }
}
