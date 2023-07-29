import 'package:easysave/utils/helpers/card_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../consts/app_colors.dart';
import '../../controller/home/home_controller.dart';
import '../../utils/helpers/design_helpers.dart';

class MajorCard extends StatelessWidget {
  const MajorCard({
    super.key,
    required this.username,
    required this.controller,
    // required this.actionWord,
  });

  final String? username;
  final HomePageController controller;
  //final String actionWord;
  // final Widget action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 200.h,
      child: Card(
          elevation: 2,
          shape: CustomCardShape(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            //firstText,
                            'Welcome,',

                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            username ?? 'f',
                            style: const TextStyle(
                                color: APPBAR_COLOR2, fontSize: 25),
                          ),
                          addVerticalSpace(5.h),
                          //SecondWidget,
                          Text(
                            'You do not have any savings goals yet.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      addVerticalSpace(4.h),
                      //widgetKK
                      ElevatedButton(
                          //style: ,
                          onPressed: () {
                            //  action
                            controller.gotoAdd();
                          },
                          child:

                              //  actionWord
                              const Text('Create new goal')),
                    ],
                  ),
                ),
              ),
              // addHorizontalSpace(5),
              Expanded(
                child: SizedBox(
                  height: 200.h,
                  width: 160.w,
                  child: const SimpleCircularProgressBar(
                    // valueNotifier: valueNotifier,
                    progressColors: [APPBAR_COLOR2],
                    backColor: APPBAR_COLOR1,
                  ),
                  // SfCircularChart(
                  //   annotations: <CircularChartAnnotation>[
                  //     CircularChartAnnotation(
                  //         widget: Container(
                  //       child: const Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             'Target Amount',
                  //             style: TextStyle(),
                  //           ),
                  //           Text(
                  //             '0,000',
                  //             //  controller.allGoals[index].targetAmount.toString(),
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold, fontSize: 16),
                  //           )
                  //         ],
                  //       ),
                  //     ))
                  //   ],
                  //   series: <CircularSeries>[
                  //     DoughnutSeries<SavingsGoals, String>(
                  //       explodeOffset: '10%',
                  //       explodeAll: true,
                  //       explodeIndex: 2,
                  //       name: 'total',
                  //       startAngle: 10,
                  //       endAngle: 10,
                  //       radius: '90%',
                  //       innerRadius: '70%',
                  //       pointColorMapper: (data, _) => APPBAR_COLOR2,
                  //       dataSource: controller.allGoals,
                  //       xValueMapper: (SavingsGoals data, _) =>
                  //           data.endDate.toIso8601String(),
                  //       yValueMapper: (SavingsGoals data, _) =>
                  //           data.targetAmount,
                  //       dataLabelSettings:
                  //           const DataLabelSettings(isVisible: true),
                  //       enableTooltip: false,
                  //     )
                  //   ],
                  // ),
                ),
              ),
            ],
          )),
    );
  }
}
