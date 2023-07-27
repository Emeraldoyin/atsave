import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/config/theme/app_theme.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/utils/helpers/design_helpers.dart';
import 'package:easysave/view/widgets/savings_goals_card.dart';
import 'package:easysave/view/widgets/show_dialog.dart';
import 'package:easysave/view/widgets/text_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../consts/app_colors.dart';
import '../../controller/home/goal_details_controller.dart';
import '../../model/category.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import '../../utils/helpers/date_formatter.dart';
import '../../utils/helpers/get_downloard.dart';

class GoalDetailsPage
    extends StatelessView<GoalDetails, GoalDetailsController> {
  const GoalDetailsPage(GoalDetailsController controller, SavingsGoals goal,
      {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(widget.goal.goalNotes!.toUpperCase()),
        ),
        body: body(context));
  }

  Widget body(context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is DbLoadingState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40.w, top: 100.h),
                child: Image.asset('assets/images/Piggy bank with coins.png'),
              ),
              const CircularProgressIndicator(),
            ],
          );
        } else if (state is DbSuccessState) {
          log(state.availableCategories.toString(), name: 'category');
          List<Category> categories = state.availableCategories;
          Category myCategory = categories
              .firstWhere((element) => element.id == widget.goal.categoryId);
          String formattedDate = formatDateTime(widget.goal.endDate);
          return SafeArea(
              child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                SizedBox(
                    height: 200.h, child: SavingsGoalCard(goal: widget.goal)),
                addVerticalSpace(16.h),
                Row(
                  children: [
                    Text(
                      'Goal Details',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    addHorizontalSpace(120.w),
                    SizedBox(
                      height: 35.h,
                      width: 35.w,
                      child: IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/images/pin.png')),
                    ),
                    SizedBox(
                      height: 35.h,
                      width: 35.w,
                      child: IconButton(
                          onPressed: () {
                            controller.onClickEdit();
                          },
                          icon: Image.asset('assets/images/edit.png')),
                    ),
                    SizedBox(
                      height: 35.h,
                      width: 35.w,
                      child: IconButton(
                          onPressed: () {
                            showDeleteDialog(widget.goal, context, state);
                          },
                          icon: Image.asset('assets/images/trash.png')),
                    ),
                  ],
                ),
                addVerticalSpace(16.h),
                Container(
                  height: 600.h,
                  width: double.infinity.w,
                  decoration: const BoxDecoration(color: HINT_TEXT_COLOR),
                  child: Form(
                      child: Column(
                    children: [
                      Text('Goal Description',
                          style: Theme.of(context).textTheme.bodySmall),
                      addVerticalSpace(5.h),
                      textContainer(widget.goal.goalNotes!, context),
                      addVerticalSpace(5.h),
                      Text('Target Amount',
                          style: Theme.of(context).textTheme.bodySmall),
                      addVerticalSpace(5.h),
                      textContainer(
                          '\$${widget.goal.targetAmount.toStringAsFixed(2)}',
                          context),
                      addVerticalSpace(5.h),
                      Text('Already Saved',
                          style: Theme.of(context).textTheme.bodySmall),
                      addVerticalSpace(5.h),
                      textContainer(
                          '\$${widget.goal.currentAmount.toStringAsFixed(2)}',
                          context),
                      addVerticalSpace(5.h),
                      Text('Proposed Goal Completion Date',
                          style: Theme.of(context).textTheme.bodySmall),
                      addVerticalSpace(5.h),
                      textContainer(formattedDate, context),
                      addVerticalSpace(5.h),
                      Text('Goal Category',
                          style: Theme.of(context).textTheme.bodySmall),
                      addVerticalSpace(5.h),
                      textContainer(myCategory.name, context),
                      addVerticalSpace(16.h),
                      SizedBox(
                        width: 240.w,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: FutureBuilder<String>(
                                future: getDownloadUrl(myCategory.id!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return CachedNetworkImage(
                                      width: double.infinity,
                                      height: 70,
                                      imageUrl: snapshot.data!,
                                      fit: BoxFit.cover,
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text('Error loading image');
                                  }
                                  return const CircularProgressIndicator();
                                }),
                          ),
                        ),
                      ),
                      addVerticalSpace(24.h),
                      ElevatedButton(
                          onPressed: () {},
                          child: const Text('Continue Saving'))
                    ],
                  )),
                )
              ],
            ),
          ));
        }
        return Container();
      },
    );
  }
}
