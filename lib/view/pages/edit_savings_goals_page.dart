import 'package:easysave/config/theme/app_theme.dart';
import 'package:easysave/utils/helpers/comma_formatter.dart';
import 'package:easysave/utils/helpers/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/home/goal_details_controller.dart';
import '../../model/savings_goals.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import '../../utils/helpers/design_helpers.dart';
import '../../utils/helpers/input_formatter.dart';

class EditSavingsGoalPage
    extends StatelessView<GoalDetails, GoalDetailsController> {
  const EditSavingsGoalPage(
      GoalDetailsController controller, SavingsGoals myGoal,
      {Key? key})
      : super(controller, key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Edit '),
        ),
        body: body(context));
  }

  Widget body(context) {
    controller.currentAmountController.text =
        formatDoubleWithComma(widget.goal.currentAmount);
    controller.targetAmountController.text =
        formatDoubleWithComma(widget.goal.targetAmount);
    String datee = formatDateTime(widget.goal.endDate);
    controller.goalNotesController.text = widget.goal.goalNotes.toString();
    controller.proposedEndDateController.text = datee;
    List<DropdownMenuItem<String>> dropdownItems =
        widget.categories.map((category) {
      return DropdownMenuItem<String>(
        value: category.name,
        child: Text(category.name),
      );
    }).toList();
    // controller.categoryController.text = widget.goal.categoryId.toString();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.0.w),
      child: SingleChildScrollView(
        child: Form(
          key: controller.editGoalFormKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 190.w),
                child: Text(
                  'Goal Details',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              addVerticalSpace(32.h),
              TextFormField(
                validator: (value) => controller.validateAmount(value),
                controller: controller.targetAmountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  //FilteringTextInputFormatter.allow(controller.decimalRegex),
                  CommaTextInputFormatter()
                ],
                decoration: const InputDecoration(
                  labelText: 'Target Amount',
                ),
              ),
              addVerticalSpace(32.h),
              TextFormField(
                validator: (value) => controller.validate(value),
                controller: controller.goalNotesController,
                decoration: const InputDecoration(
                  labelText: 'Goal Notes',
                ),
              ),
              addVerticalSpace(32.h),
              TextFormField(
                validator: (value) => controller.validateAmount(value),
                controller: controller.currentAmountController,
                decoration: const InputDecoration(
                  labelText: 'How much are you saving now?',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [CommaTextInputFormatter()],
              ),
              addVerticalSpace(32.h),
              DropdownButtonFormField(
                validator: (value) => controller.validate(value),
                value: controller.selectedCategory,
                items: dropdownItems,
                onChanged: (value) {
                  controller.onCategoryClicked(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
              ),
              addVerticalSpace(32.h),
              GestureDetector(
                onTap: () async {
                  controller.onTap();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    validator: (value) => controller.validate(value),
                    controller: controller.proposedEndDateController,
                    decoration: const InputDecoration(
                      labelText: 'Proposed Goal Completion Date',
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 250),
                child: SizedBox(height: 32.0),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.onEditGoal();
                },
                child: const Text('Save changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
