import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/home/home_controller.dart';
import '../../model/category.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';
import '../../utils/helpers/design_helpers.dart';
import '../../utils/helpers/input_formatter.dart';

class AddSavingsGoalPage extends StatelessView<Home, HomePageController> {
  const AddSavingsGoalPage(HomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is DbSuccessState) {
          List<Category> categories = state.availableCategories;
          List<DropdownMenuItem<String>> dropdownItems =
              categories.map((category) {
            return DropdownMenuItem<String>(
              value: category.name,
              child: Text(category.name),
            );
          }).toList();
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: const Text('Add Savings Goal'),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(32.0.r),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.addGoalFormKey,
                  child: Column(
                    children: [
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
                        controller: controller.startAmountController,
                        decoration: const InputDecoration(
                          labelText: 'How much are you saving now?',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [CommaTextInputFormatter()],
                      ),
                      addVerticalSpace(32.h),
                      DropdownButtonFormField(
                        validator: (value) =>
                            controller.validateCategory(value),
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
                            validator: (value) =>
                                controller.validateCategory(value),
                            controller: controller.proposedEndDateController,
                            decoration: const InputDecoration(
                              labelText: 'Proposed Goal Completion Date',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: () {
                          controller.onSaveGoal();
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
        return Container();
      },
    );
  }
}
