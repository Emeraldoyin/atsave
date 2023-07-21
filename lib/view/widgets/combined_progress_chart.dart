import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CombinedProgressChart extends StatelessWidget {
  final List<ChartData> chartData;

  CombinedProgressChart({required this.chartData});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      series: <CircularSeries>[
        DoughnutSeries<ChartData, double>(
          dataSource: chartData,
          xValueMapper: (data, _) => data.x,
          yValueMapper: (data, _) => data.y,
          pointColorMapper: (data, _) {
            double percentage = data.y;
            if (percentage >= 100) {
              return Colors.green;
            } else if (percentage >= 50) {
              return Colors.orange;
            } else {
              return Colors.red;
            }
          },
          dataLabelMapper: (data, _) => '${data.y}%',
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}


class ChartData {
  final double x;
  final double y;
 final String goalNotes; // Add goalNotes property

  ChartData(this.x, this.y, this.goalNotes);
 
}