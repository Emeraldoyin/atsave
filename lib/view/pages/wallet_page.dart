import 'package:easysave/model/category.dart';
import 'package:easysave/utils/helpers/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/app_theme.dart';
import '../../consts/app_images.dart';
import '../../consts/app_texts.dart';
import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import '../../utils/helpers/design_helpers.dart';

class WalletPage extends StatelessView<Home, HomePageController> {
  const WalletPage(HomePageController controller, {Key? key})
      : super(controller, key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: const Text('Wallet'),
          ),
        ),
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        body: SingleChildScrollView(child: body(context)));
  }

  Widget body(context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            addVerticalSpace(16.h),
            Container(
                padding:
                    EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 16.w),
                // height: 138.h,
                width: 284.w,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 1)
                ], color: Color.fromARGB(255, 65, 219, 155)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50.w,
                        height: 15.21.h,
                        child: Image.asset(image28)),
                    addVerticalSpace(4.h),
                    Text(
                      '**** **** **** 3478',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    addVerticalSpace(8.h),
                    Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Andrew Jones',
                        ),
                        addHorizontalSpace(
                          95.w,
                        ),
                        Text(formatDateTimeToDayMonth(DateTime.now()),
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    addVerticalSpace(8.h),

                    Text('150,000 dollars',
                        style: Theme.of(context).textTheme.bodyLarge),

                    //  addVerticalSpace(4.h)
                  ],
                )),
            addVerticalSpace(16.h),
            const Text('Today'),
            addVerticalSpace(16.h),
            ListView.builder(
                shrinkWrap:
                    true, // Set shrinkWrap to true to avoid height conflicts
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scroll in ListView
                itemCount: categoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  Category category = categoryList[index];
                  return Padding(
                    padding: EdgeInsets.all(2.0.r),
                    child: Card(
                      elevation: 1,
                      child: ListTile(
                          title: Text(
                            "something", //formatDateTime(controller.allGoals[1].endDate),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          subtitle: const Text(
                              "something"), // controller.allGoals[1].goalNotes!),
                          leading: CircleAvatar(
                            radius:
                                20, // Set the radius to control the size of the CircleAvatar
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              category.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                          trailing: const Text(
                            "something", //'\$${controller.allGoals[1].currentAmount.toString()}',
                          )),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
