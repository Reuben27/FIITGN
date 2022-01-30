import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Time_BarChartWidget extends StatelessWidget {
  final List<int> time_per_km;
  final List<double> speed_per_km;
  Time_BarChartWidget({
    @required this.speed_per_km,
    @required this.time_per_km,
  });
  // final List<int> kms
  List<BarChartGroupData> ret = [];
  conv_time_into_bardata(List<int> time_per_km) {
    for (int i = 0; i < time_per_km.length; i++) {
      ret.add(
        BarChartGroupData(x: i + 1, barRods: [
          BarChartRodData(
            y: time_per_km[i] + 0.0,
            width: 10,
            colors: [Colors.amber],
            // borderRadius:
          )
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      alignment: BarChartAlignment.center,
      maxY: (speed_per_km.length + 1.0),
      minY: 0.0,
      groupsSpace: 12,
      barTouchData: BarTouchData(enabled: true),
    ));
  }
}

class BarData {}
