import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import '../../utils/helpers/design_helpers.dart';

class AddSavingsGoalPage extends StatelessView<Home, HomePageController> {
  const AddSavingsGoalPage(HomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Savings Goal'),
      ),
      body: Padding(
        padding: EdgeInsets.all(32.0.r),
        child: SingleChildScrollView(
          child: Form(
            key: controller.addGoalFormKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) => controller.validate(value),
                  controller: controller.targetAmountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(controller.decimalRegex),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Target Amount',
                  ),
                ),
                addVerticalSpace(16.h),
                TextFormField(
                  validator: (value) => controller.validate(value),
                  controller: controller.goalNotesController,
                  decoration: const InputDecoration(
                    labelText: 'Goal Notes',
                  ),
                ),
                addVerticalSpace(16.h),
                TextFormField(
                  validator: (value) => controller.validate(value),
                  controller: controller.startAmountController,
                  decoration: const InputDecoration(
                    labelText: 'How much are you saving now?',
                  ),
                ),
                addVerticalSpace(16.h),
                DropdownButtonFormField(
                  validator: (value) => controller.validate(value),
                  value: controller.selectedCategory,
                  items: controller.dropdownItems,
                  onChanged: (value) {
                    controller.onCategoryClicked(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                ),
                addVerticalSpace(16.h),
                TextFormField(
                  validator: (value) => controller.validate(value),
                  controller: controller.proposedEndDateController,
                  decoration: const InputDecoration(
                    labelText: 'Proposed Goal Completion Date',
                  ),
                  onTap: () async {
                    controller.onTap();
                  },
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    controller.onSaveGoal(controller.addGoalFormKey);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
