import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/consts/app_images.dart';
import 'package:easysave/controller/home/goal_details_controller.dart';
import 'package:easysave/controller/home/home_controller.dart';
import 'package:easysave/utils/helpers/double_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

import '../../controller/signup/success_controller.dart';
import '../../utils/helpers/input_formatter.dart';

showNumberInputDialog(BuildContext context, GoalDetailsController controller,
    double amountRemaining) {
  // Setting the text field controller to an empty string before showing the dialog
  controller.newAmountController.text = '';

  // The user-inputted savings amount
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor: HINT_TEXT_COLOR,
        title: const Text('Enter New Savings Amount'),
        content: Form(
          key: controller.addAmountFormKey,
          child: TextFormField(
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    size: 16.r,
                  ),
                  onPressed: () {
                    controller.newAmountController.clear();
                  }),
            ),
            onSaved: (value) => controller.newAmountController.text = value!,
            validator:
                ValidationBuilder().required('This field is required').build(),
            controller: controller.newAmountController,
            keyboardType: TextInputType.number, // Show number keyboard
            inputFormatters: [CommaTextInputFormatter()],
          ),
        ),
        actions: [
          BlocBuilder<ConnectivityBloc, ConnectivityState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  // Check if the form is valid before performing the action
                  if (controller.addAmountFormKey.currentState!.validate()) {
                    if (parseStringToDouble(
                            controller.newAmountController.text) <=
                        amountRemaining) {
                      controller.onEditCurrentAmount(
                          parseStringToDouble(
                              controller.newAmountController.text),
                          amountRemaining);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Success(
                                    succcessful: true,
                                    amount:
                                        controller.targetAmountController.text,
                                    displayMessage: 'Congratulations!!!',
                                    displayImageURL: image16,
                                    buttonText: 'Done',
                                    displaySubText:
                                        'You have successfully added ${controller.newAmountController.text} to your savings goal',
                                    destination: const Home(),
                                  )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'The amount you\'re trying to save is more than the target amount.'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 5),
                        backgroundColor: APPBAR_COLOR2,
                      ));
                    }
                    // Form validation succeeded, perform the action here.
                  }
                },
                child: state is DbLoadingState
                    ? const CircularProgressIndicator()
                    : const Text('Save'),
              );
            },
          )
        ],
      );
    },
  );
}

showNumberInputDialogForExpense(
    BuildContext context, GoalDetailsController controller) {
  // Setting the text field controller to an empty string before showing the dialog
  controller.spentAmountController.text = '';
  // List<DropdownMenuItem<String>> dropdownItems =
  //     controller.widget.categories.map((category) {
  //   return DropdownMenuItem<String>(
  //     value: category.name,
  //     child: Text(category.name),
  //   );
  // }).toList();
  // The user-inputted savings amount
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor: HINT_TEXT_COLOR,
        title: const Text('Enter Amount To Withdraw'),
        content: Form(
          key: controller.spendAmountFormKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 16.r,
                      ),
                      onPressed: () {
                        controller.spentAmountController.clear();
                      }),
                ),
                onSaved: (value) =>
                    controller.spentAmountController.text = value!,
                validator: ValidationBuilder()
                    .required('This field is required')
                    .build(),
                controller: controller.spentAmountController,
                keyboardType: TextInputType.number, // Show number keyboard
                inputFormatters: [CommaTextInputFormatter()],
              ),
              // DropdownButtonFormField(
              //   validator: (value) => controller.validateCategory(value),
              //   value: controller.selectedCategory,
              //   items: dropdownItems,
              //   onChanged: (value) {
              //     controller.onCategoryClicked(value);
              //   },
              //   decoration: const InputDecoration(
              //     labelText: 'Why are you withdrawing?',
              //   ),
              // ),
            ],
          ),
        ),
        actions: [
          BlocBuilder<ConnectivityBloc, ConnectivityState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  // Check if the form is valid before performing the action
                  if (controller.spendAmountFormKey.currentState!.validate()) {
                    // Form validation succeeded, perform the action here.
                    if (parseStringToDouble(
                            controller.spentAmountController.text) <=
                        controller.widget.goal.currentAmount) {
                      controller.onWithdraw(
                        parseStringToDouble(
                            controller.spentAmountController.text),
                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Success(
                                    succcessful: true,
                                    amount:
                                        controller.targetAmountController.text,
                                    displayMessage:
                                        '${controller.spentAmountController.text} withrawn',
                                    displayImageURL: image16,
                                    buttonText: 'Done',
                                    displaySubText:
                                        'You have successfully withdrawn ${controller.spentAmountController.text} from your savings goal',
                                    destination: const Home(),
                                  )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'The amount you\'re trying to withdraw is more than the amount you have in savings.'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 5),
                        backgroundColor: APPBAR_COLOR2,
                      ));
                    }
                  }
                },
                child: state is DbLoadingState
                    ? const CircularProgressIndicator()
                    : const Text('Save'),
              );
            },
          )
        ],
      );
    },
  );
}
