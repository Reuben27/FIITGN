import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Additional_stats_screen extends StatelessWidget {
  List<double> pace_calculator(List<int> time) {
    List<double> paces = [];
    for (int time_val in time) {
      // time val is in secs we need to get it in minutes
      double minutes =
          double.parse(((time_val + 0.0) / 60.0).toStringAsFixed(2));
      // double pace = double.parse((minutes/1000).toString());
      paces.add(minutes);
    }
    return paces;
  }

  List<int> timePerKmcomponent(int time) {
    // double hours = (time + 0.0) % 3600;
    // time = time - hours * 3600;
    int mins = ((time) / 60).floor();
    time = time - (mins * 60);
    int secs = time;
    // assert hours>=0 && mins>=0 && secs>=0;
    List<int> ret = [mins, secs];
    return ret;
  }

  List<double> pace_list = [
    6.02,
    6.01,
    5.41,
    4.72,
    7.88,
    7.21,
    8.22,
    9.22,
    5.01,
    6.31,
    5.33,
    8.54,
    9.87,
    8.76,
    8.22,
    // 9.22,
    // 5.01,
    // 6.31,
    // 5.33,
  ];

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
                y: value,
                colors: [Colors.amber],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                )),
          ],
        ),
      );
    });
    return ret;
  }

  // const Additional_stats_screen({ Key? key }) : super(key: key);
  static const routeName = '\additional_stats_screen';
  @override
  // Widget build(BuildContext context) {
  //   final routeArgs = ModalRoute.of(context).settings.arguments as Map;
  //   List<int> time_per_km = routeArgs['time_per_km'];
  //   // List<double> speed_per_km = routeArgs['speed_per_km'];
  //   List<double> pace_list = pace_calculator(time_per_km);

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Additional Stats'),
  //     ),
  //     body: time_per_km.length == 0
  //         ? Center(
  //             child: Text('Distance covered to less to generate stats'),
  //           )
  //         : ListView.builder(
  //             itemCount: time_per_km.length,
  //             itemBuilder: (ctx, i) {
  //               List<int> time_comps = timePerKmcomponent(time_per_km[i]);
  //               print('Km :' + (i + 1).toString());
  //               print('Av pace- ' + pace_list[i].toString());
  //               // print('Av speed- ' + (speed_per_km[i].toString()));
  //               print('Av time- ' +
  //                   time_comps[0].toString() +
  //                   'mins' +
  //                   time_comps[1].toString() +
  //                   'secs');
  //               return Row(
  //                 children: [
  //                   Text('Km- ' + (i + 1).toString()),
  //                   Text('Av pace- ' + pace_list[i].toString()),
  //                   Text('Av time- ' +
  //                       time_comps[0].toString() +
  //                       ':' +
  //                       time_comps[1].toString())
  //                 ],
  //               );
  //             },
  //           ),
  //   );
  // }
  Widget build(BuildContext context) {
    List<BarChartGroupData> l = go(pace_list);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BarChart(BarChartData(
          alignment: BarChartAlignment.center,
          // maxY: (speed_per_km.length + 1.0),
          groupsSpace: 5,
          barTouchData: BarTouchData(enabled: true),
          backgroundColor: Colors.black,
          barGroups: l,
        )),
      ),
    );
  }
}
