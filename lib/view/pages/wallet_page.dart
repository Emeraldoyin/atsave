import 'dart:developer';

import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/model/category.dart';
import 'package:easysave/utils/helpers/comma_formatter.dart';
import 'package:easysave/utils/helpers/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        body: SingleChildScrollView(
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
                    BoxShadow(
                        color: Colors.grey, blurRadius: 10, spreadRadius: 1)
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
                          Text(
                            controller.user!.displayName!,
                          ),
                          addHorizontalSpace(
                            95.w,
                          ),
                          Text(formatDateTimeToDayMonth(DateTime.now()),
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      addVerticalSpace(8.h),

                      Text(
                          '${controller.getAlreadySaved(controller.allGoals)} dollars',
                          style: Theme.of(context).textTheme.bodyLarge),

                      //  addVerticalSpace(4.h)
                    ],
                  )),
              addVerticalSpace(16.h),
              const Text('Available'),
              addVerticalSpace(16.h),
              BlocBuilder<ConnectivityBloc, ConnectivityState>(
                  builder: (context, state) {
                if (state is DbSuccessState &&
                    state.availableSavingsTransactions != null &&
                    state.availableSavingsTransactions!.isNotEmpty) {
                  List<Category> categories = [];
                  for (var i in categoryList) {
                    if (state.availableSavingsGoals
                        .any((element) => element.categoryId == i.id)) {
                      categories.add(i);
                    }
                  }
                  log(categories.length.toString());

                  return ListView.builder(
                    shrinkWrap:
                        true, // Set shrinkWrap to true to avoid height conflicts
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable scroll in ListView
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      double currentAmount = 0;
                      double targetAmount = 0;
                      for (var element in state.availableSavingsGoals.where(
                          (element) =>
                              element.categoryId == categories[index].id)) {
                        currentAmount += element.currentAmount;
                        targetAmount += element.targetAmount;
                      }

                      return Padding(
                        padding: EdgeInsets.all(2.0.r),
                        child: Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(categories[index].name),
                            subtitle: Text(
                              '\$${formatDoubleWithComma(currentAmount)}', //formatDateTime(controller.allGoals[1].endDate),
                              style: Theme.of(context).textTheme.labelMedium,
                            ), // controller.allGoals[1].goalNotes!),
                            leading: CircleAvatar(
                              radius:
                                  20, // Set the radius to control the size of the CircleAvatar
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                categories[index].imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                            trailing: currentAmount == targetAmount
                                ? Text(
                                    'current', //formatDateTime(controller.allGoals[1].endDate),
                                    style:
                                        Theme.of(context).textTheme.labelSmall)
                                : Text(
                                    'Goal:\$${formatDoubleWithComma(targetAmount)}', //formatDateTime(controller.allGoals[1].endDate),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is DbSuccessState &&
                    state.availableSavingsTransactions != null &&
                    state.availableSavingsTransactions!.isEmpty) {
                  return Center(
                      child: Column(
                    children: [
                      const Text('No money saved yet'),
                      Image.asset(image5),
                    ],
                  ));
                }
                return const Center(child: CircularProgressIndicator());
              })
            ],
          ),
        )));
  }
}
