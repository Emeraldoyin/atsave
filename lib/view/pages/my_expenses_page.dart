// import 'package:easysave/config/theme/app_theme.dart';
// import 'package:flutter/material.dart';

// import '../../controller/home/home_controller.dart';
// import '../../utils/helpers/boilerplate/stateless_view.dart';

// class MyExpensesPage extends StatelessView<Home, HomePageController> {
//   const MyExpensesPage(HomePageController controller, {Key? key})
//       : super(controller, key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
//         body: body(context));
//   }

//   Widget body(context) {
//     return SingleChildScrollView();
//   }
// }
// class myExpenses extends StatelessWidget {
//   myGoals(
//       {super.key,
//       required this.username,
//       required this.controller,
//       required this.allGoals});

//   final String? username;
//   final HomePageController controller;
//   List<SavingsGoals?> allGoals;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: SingleChildScrollView(
//       child: controller.allGoals.isNotEmpty
//           ? SizedBox(
//               height: 250.h,
//               width: 130.w,
//               child: ListView.builder(
//                 itemCount: controller.allGoals.length,
//                 itemBuilder: (context, index) {
//                   final goal = controller.allGoals[index];
//                   return SavingsGoalCard(
//                     goalName: goal.goalNotes,
//                     goalAmount: goal.targetAmount,
//                     completionDate: goal.endDate.toIso8601String(),
//                   );
//                 },
//               ),
//             )
//           : Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: majorCard(username: username, controller: controller),
//                 ),
//                 SizedBox(
//                   child: Image.asset('assets/images/onboard_img2.png'),
//                 )
//               ],
//             ),
//     ));
//   }
// }
