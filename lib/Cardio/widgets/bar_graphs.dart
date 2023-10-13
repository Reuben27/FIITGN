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
            fromY: time_per_km[i] + 0.0,
            width: 20,
            color: Colors.amber,
            // borderRadius:
          )
        ]),
      );
    }
  }

  List pace_list = [
    6.31,
  ];

  List<BarChartGroupData> go(List<double> l) {
    Map m = {};
    List<BarChartGroupData> ret = [];
    for (int i = 0; i < l.length; i++) {
      m[i + 1] = l[i];
    }
    m.forEach((key, value) {
      ret.add(
        BarChartGroupData(
          x: key,
          barRods: [
            BarChartRodData(
                fromY: value,
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                )),
          ],
        ),
      );
    });
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> l = go(pace_list);
    return BarChart(BarChartData(
        alignment: BarChartAlignment.center,
        maxY: (speed_per_km.length + 1.0),
        minY: 0.0,
        groupsSpace: 12,
        barTouchData: BarTouchData(enabled: true),
        backgroundColor: Colors.white,
        barGroups: l,
      ),
    );
  }
}
