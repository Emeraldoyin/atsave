import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../controller/home/home_controller.dart';
import '../../model/expenses.dart';
import '../../utils/helpers/design_helpers.dart';

class smallerCard extends StatelessWidget {
  const smallerCard({
    super.key,
    required this.username,
    required this.controller,
  });

  final String? username;
  final HomePageController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:164.h,
      width: 188.w,
      child: Card(
          elevation: 2,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80.h,
                      width: 130.w,
                      child: Column(
                        children: [
                          Text(
                            'Welcome, $username!',
                            style:
                                Theme.of(context).textTheme.displayMedium,
                          ),
                          addVerticalSpace(5.h),
                          Text(
                            'You do not have any savings goals yet.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        //style: ,
                        onPressed: () {},
                        child: const Text('Create new goal')),
                    addVerticalSpace(10),
                  ],
                ),
              ),
              // addHorizontalSpace(5),
              SizedBox(
                height: 200.h,
                width: 180.w,
                child: SfCircularChart(
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                        widget: Container(
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Target Amount',
                            style: TextStyle(),
                          ),
                          Text(
                            '\$ 0 000',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ))
                  ],
                  series: <CircularSeries>[
                    DoughnutSeries<Expenses, String>(
                      explodeOffset: '10%',
                      explodeAll: true,
                      explodeIndex: 2,
                      name: 'total',
                      startAngle: 10,
                      endAngle: 10,
                      //endAngle: 10,
                      radius: '90%',
                      innerRadius: '70%',
                      //pointColorMapper: (Expenses data, _) => data.date,
                      dataSource: controller.getExpenses(),
                      xValueMapper: (Expenses data, _) => data.date,
                      yValueMapper: (Expenses data, _) =>
                          data.amountSpent,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                      enableTooltip: false,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}