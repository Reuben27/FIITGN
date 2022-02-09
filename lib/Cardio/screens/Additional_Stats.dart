import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Additional_stats extends StatefulWidget {
  // Additional_stats({Key? key}) : super(key: key);
  static const routeName = '\Additional_stats';
  @override
  State<Additional_stats> createState() => _Additional_statsState();
}

class _Additional_statsState extends State<Additional_stats> {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    List<double> altitude_list = routeArgs['altitude_list'] as List<double>;
    List<double> pace_list = routeArgs['pace_list'] as List<double>;
    String distance = routeArgs['distance'];
    String max_elevation = routeArgs['max_elevation'];
    String av_pace = routeArgs['average_pace'];
    String time = routeArgs['time'];

    return Scaffold(
        appBar: AppBar(
          title: Text('Cardio Details'),
        ),
        body: //(pace_list.length == 0 && altitude_list.length == 0)
            (false)
                ? Center(
                    child: Text('Insufficient Data, sorry!'),
                  )
                :
                ListView(
                    children: [
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: ListTile(
                                title: Text(distance, 
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                  textAlign: TextAlign.center
                                ),
                                subtitle: Text('Distance', 
                                  style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 2,
                                  ),
                                  textAlign: TextAlign.center
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: ListTile(
                                title: Text(time,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                  textAlign: TextAlign.center
                                ),
                                subtitle: Text('Total Time', 
                                  style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 2,
                                  ),
                                  textAlign: TextAlign.center
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(av_pace, 
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                                textAlign: TextAlign.center
                              ),
                              subtitle: Text('Average Pace', 
                                style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 2,
                                  ),
                                  textAlign: TextAlign.center
                                ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                max_elevation, 
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                                textAlign: TextAlign.center
                              ),
                              subtitle: Text('Max Elevation',
                                style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 2,
                                  ),
                                  textAlign: TextAlign.center
                                ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: Text('Elevation Graph',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                              width: 450,
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ElevationWidget(
                                    altitude_list: altitude_list,
                                    max_alt: max_elevation),
                              ))),
                      SizedBox(height: 30),
                      Center(
                        child: Text('Pace Graph',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                            width: 450,
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: PaceChartWidget(pace_list: pace_list),
                            )),
                      ),
                    ],
                  ));
  }
}

class ElevationWidget extends StatelessWidget {
  final List<double> altitude_list;
  final String max_alt;

  ElevationWidget({
    @required this.altitude_list,
    @required this.max_alt,
  });

  List<FlSpot> get_spots(List<double> altitude_list) {
    List<FlSpot> spots = [];
    for (int i = 0; i < altitude_list.length; i++) {
      spots.add(
        FlSpot(
          i + 0.0,
          altitude_list[i],
        ),
      );
    }
    return spots;
  }

  // use this while testing the graph
  final List<FlSpot> dummy_data = [
    FlSpot(0, 2.3),
    FlSpot(1, 2.3),
    FlSpot(2, 1.3),
    FlSpot(3, 1.5),
    FlSpot(4, 3),
    FlSpot(5, 5.2),
    FlSpot(6, 4.5),
    FlSpot(7, 6.5),
    FlSpot(8, 7.2),
    FlSpot(9, 7.1),
    FlSpot(10, 7.0),
    FlSpot(11, 7.6),
    FlSpot(12, 1.3),
    FlSpot(13, 1.5),
    FlSpot(14, 3),
    FlSpot(15, 5.2),
    FlSpot(16, 4.5),
    FlSpot(17, 6.5),
    FlSpot(18, 7.2),
    FlSpot(19, 7.1),
    FlSpot(20, 7.0),
    FlSpot(21, 7.6),
    FlSpot(22, 7.6),
    FlSpot(23, 1.3),
    FlSpot(24, 1.5),
    FlSpot(25, 3),
    FlSpot(26, 5.2),
    FlSpot(27, 4.5),
    FlSpot(28, 6.5),
    FlSpot(29, 7.2),
    FlSpot(30, 7.1),
    FlSpot(31, 7.0),
    FlSpot(32, 7.6),
    FlSpot(33, 1.5),
    FlSpot(34, 3),
    FlSpot(35, 5.2),
    FlSpot(36, 4.5),
    FlSpot(37, 6.5),
    FlSpot(38, 7.2),
    FlSpot(39, 7.1),
    FlSpot(40, 7.0),
    FlSpot(41, 7.6),
    FlSpot(42, 7.6),
    FlSpot(43, 1.3),
    FlSpot(44, 1.5),
    FlSpot(45, 3),
    FlSpot(46, 5.2),
    FlSpot(47, 4.5),
    FlSpot(48, 6.5),
    FlSpot(49, 7.2),
  ];

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a)
  ];

  @override
  Widget build(BuildContext context) {
    double max_altitude = double.parse('10.0');
    double min_altitude = 0.0;
    // Use this in real
    // List<FlSpot> spots = get_spots(altitude_list);
    // This is for testing
    List<FlSpot> spots = dummy_data;
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: spots.length + 0.0,
        minY: min_altitude,
        maxY: max_altitude,
        clipData: FlClipData.all(),
        titlesData: FlTitlesData(
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(showTitles: false),
          leftTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            margin: 8,
            interval: 2,
            getTitles: (value) {
              return (value.toInt().toString() + 'm');
            },
          ),
        ),
        axisTitleData: FlAxisTitleData(
          bottomTitle: AxisTitle(
            showTitle: true, 
            titleText: 'Distance',
            textStyle: TextStyle(
              color: Colors.black, 
              fontSize: 18,
            )
          )
        ),
        gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: const Color(0xff37434d), strokeWidth: 1),
            drawHorizontalLine: true),
        borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1)),
        lineBarsData: [
          LineChartBarData(
              spots: spots,
              isCurved: true,
              colors: gradientColors,
              barWidth: 5,
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors
                    .map(
                      (color) => color.withOpacity(0.3),
                    )
                    .toList(),
              )),
        ],
      ),
    );
  }
}

class PaceChartWidget extends StatelessWidget {
  final List<double> pace_list;

  PaceChartWidget({
    @required this.pace_list,
  });

  List<FlSpot> get_spots(List<double> pace_list) {
    List<FlSpot> spots = [];
    for (int i = 0; i < pace_list.length; i++) {
      spots.add(
        FlSpot(
          i + 1.0,
          pace_list[i],
        ),
      );
    }
    return spots;
  }

  // use this while testing the graph
  final List<FlSpot> dummy_data = [
    FlSpot(0, 6.3),
    FlSpot(1, 7.3),
    FlSpot(2, 5.3),
    FlSpot(3, 3.5),
    FlSpot(4, 6),
    FlSpot(5, 7.2),
    FlSpot(6, 6.5),
    FlSpot(7, 6.5),
    FlSpot(8, 5.2),
    FlSpot(9, 7.1),
    FlSpot(10, 6.0),
    FlSpot(11, 7.6),
    FlSpot(12, 6.3),
    FlSpot(13, 5.5),
    FlSpot(14, 7),
    FlSpot(15, 6.2),
    FlSpot(16, 6.5),
    FlSpot(17, 6.5),
    FlSpot(18, 7.2),
    FlSpot(19, 7.1),
    FlSpot(20, 7.0),
    FlSpot(21, 7.3),
    FlSpot(22, 5.3),
    FlSpot(23, 3.5),
    FlSpot(24, 6),
    FlSpot(25, 7.2),
    FlSpot(26, 6.5),
    FlSpot(27, 6.5),
    FlSpot(28, 5.2),
    FlSpot(29, 7.1),
  ];

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a)
  ];

  get_max_pace(List<double> pace_list) {
    double max_pace = 0.0;
    for (double pace in pace_list) {
      if (pace > max_pace) {
        max_pace = pace;
      }
    }
    return max_pace;
  }

  @override
  Widget build(BuildContext context) {
    // This is dummy
    double max_pace = 10;

    // Use this instead
    // double max_pace = get_max_pace(pace_list);
    double min_pace = 0.0;
    // Use this in real
    // List<FlSpot> spots = get_spots(pace_list);
    // This is for testing
    List<FlSpot> spots = dummy_data;
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: spots.length + 1.0,
        minY: min_pace,
        maxY: max_pace,
        clipData: FlClipData.all(),
        titlesData: FlTitlesData(
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            margin: 8,
            interval: 5,
            getTitles: (value) {
              return (value.toInt().toString() + 'km');
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            margin: 8,
            interval: 2,
            getTitles: (value) {
              return (value.toInt().toString() + 'min');
            },
          ),
        ),
        gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: const Color(0xff37434d), strokeWidth: 1),
            drawHorizontalLine: true),
        borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1)),
        lineBarsData: [
          LineChartBarData(
              spots: spots,
              isCurved: true,
              colors: gradientColors,
              barWidth: 5,
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors
                    .map(
                      (color) => color.withOpacity(0.3),
                    )
                    .toList(),
              )),
        ],
      ),
    );
  }
}
