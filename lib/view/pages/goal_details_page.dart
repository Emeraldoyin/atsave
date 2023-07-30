import 'package:cached_network_image/cached_network_image.dart';
import 'package:easysave/consts/app_images.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/utils/helpers/design_helpers.dart';
import 'package:easysave/view/widgets/savings_goals_card.dart';
import 'package:easysave/view/widgets/show_dialog.dart';
import 'package:easysave/view/widgets/text_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../consts/app_colors.dart';
import '../../controller/home/goal_details_controller.dart';
import '../../model/category.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import '../../utils/helpers/comma_formatter.dart';
import '../../utils/helpers/date_formatter.dart';
import '../../utils/helpers/get_downloard.dart';
import '../widgets/number_dialog.dart';

class GoalDetailsPage
    extends StatelessView<GoalDetails, GoalDetailsController> {
  const GoalDetailsPage(GoalDetailsController controller, SavingsGoals goal,
      List<Category> categories,
      {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    Category myCategory = widget.categories
        .firstWhere((element) => element.id == widget.goal.categoryId);
    String formattedDate = formatDateTime(widget.goal.endDate);
    double amountRemaining =
        widget.goal.targetAmount - widget.goal.currentAmount;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Details Page'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              SizedBox(
                  height: 200.h,
                  child: SavingsGoalCard(
                    goal: widget.goal,
                    categories: widget.categories,
                  )),
              addVerticalSpace(16.h),
              Row(
                children: [
                  Text(
                    'Goal Details',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  addHorizontalSpace(100.w),
                  SizedBox(
                    height: 35.h,
                    width: 35.w,
                    child: IconButton(
                      onPressed: () {
                        controller.onPinGoal(widget.goal);
                      },
                      icon: controller.pinnedGoals.contains(widget.goal)
                          ? Image.asset(image19)
                          : Image.asset(image20),
                      color: controller.pinnedGoals.contains(widget.goal)
                          ? Colors.orange
                          : Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                    width: 35.w,
                    child: IconButton(
                        onPressed: () {
                          controller.onClickEdit();
                        },
                        icon: Image.asset(image21)),
                  ),
                  SizedBox(
                    height: 35.h,
                    width: 35.w,
                    child: IconButton(
                        onPressed: () {
                          showDeleteDialog(widget.goal, context);
                        },
                        icon: Image.asset(image22)),
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
                        '\$${formatDoubleWithComma(widget.goal.targetAmount)}',
                        context),
                    addVerticalSpace(5.h),
                    Text('Already Saved',
                        style: Theme.of(context).textTheme.bodySmall),
                    addVerticalSpace(5.h),
                    textContainer(
                        '\$${formatDoubleWithComma(widget.goal.currentAmount)}',
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
                      height: 120.h,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: FutureBuilder<String>(
                            future: getDownloadUrl(myCategory.id!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CachedNetworkImage(
                                  width: double.infinity,
                                  // height: 0,
                                  imageUrl: snapshot.data!,
                                  fit: BoxFit.contain,
                                );
                              } else if (snapshot.hasError) {
                                return const Text('Error loading image');
                              }
                              return const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator());
                            }),
                      ),
                    ),
                    addVerticalSpace(16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              showNumberInputDialog(
                                  context, controller, amountRemaining);
                            },
                            child: const Text('Add Money')),
                        TextButton(
                          onPressed: () {
                            showWithdrawDialog(
                              widget.goal,
                              controller,
                              context,
                            );
                          },
                          child: const Text('Withdraw',
                              style: TextStyle(color: ICON_COLOR5)),
                        )
                      ],
                    )
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
