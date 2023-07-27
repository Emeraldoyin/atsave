
import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/consts/app_colors.dart';
import 'package:easysave/controller/home/goal_details_controller.dart';
import 'package:easysave/controller/home/home_controller.dart';
import 'package:easysave/utils/helpers/double_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/signup/success_controller.dart';
import '../../utils/helpers/input_formatter.dart';

showNumberInputDialog(BuildContext context, GoalDetailsController controller) {
  // The user-inputted savings amount
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor: HINT_TEXT_COLOR,
        title: const Text('Enter New Savings Amount'),
        content: TextFormField(
          controller: controller.newAmountController,
          keyboardType: TextInputType.number, // Show number keyboard
          inputFormatters: [CommaTextInputFormatter()],
          // onChanged: (value) {
          //   // Update the newSavingsAmount whenever the text changes
          //   // newSavingsAmount = double.tryParse(value) ?? 0.0;
          // },
        ),
        actions: [
          BlocBuilder<ConnectivityBloc, ConnectivityState>(
              builder: (context, state) {
            return ElevatedButton(
                onPressed: () {
                  // saving the new Amount here
                

                  controller.onEditCurrentAmount(
                      parseStringToDouble(controller.newAmountController.text));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Success(
                              succcessful: true,
                              amount: controller.targetAmountController.text,
                              displayMessage: 'Congratulations!!!',
                              displayImageURL:
                                  'assets/images/money and phone.png',
                              buttonText: 'Done',
                              displaySubText:
                                  'You have succcessfully added ${controller.newAmountController.text} to your savings goal',
                              destination: const Home())));
                },
                child: state is DbLoadingState
                    ? const CircularProgressIndicator()
                    : const Text('Save'));
          })
        ],
      );
    },
  );
  //return newSavingsAmount;
}
