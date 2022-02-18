import 'package:fiitgn/Cardio/screens/Additional_Stats.dart';
import 'package:fiitgn/Providers/DataProvider.dart';

import '../providers/RunModel.dart';
import 'package:flutter/material.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/RunDataProvider.dart';
import '../../Screens/HomeScreen.dart';
import 'PolylineShow.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;
// import "package:latlong/latlong.dart" as latLng;

class ShowResultsScreen extends StatefulWidget {
  static const routeName = '\showResultsScreen';

  @override
  _ShowResultsScreenState createState() => _ShowResultsScreenState();
}

class _ShowResultsScreenState extends State<ShowResultsScreen> {
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

  final primaryColorThisScreen = Color(0XFF6D3FFF);

  final accentColorThisScreen = Color(0XFF233C63);

  Widget createSmallMap(Map args) {
    final double initialLatitude = args['initialLat'];
    final double initialLongitude = args['initialLong'];
    List<dynamic> listOfCoordinates = args['listOfLatLng'];

    // final runStatsProvider = Provider.of<RunDataProvider>(context);
    // final List<RunModel> runStats = runStatsProvider.yourRunsList;
    // final double initialLatitude = runStats[index].initialLatitude;
    // final double initialLongitude = runStats[index].initialLongitude;
    // List<dynamic> listOfCoordinates = runStats[index].listOfLatLng;
    List<latLng.LatLng> listOfPolyLineLatLng = [];

    for (int i = 0; i < listOfCoordinates.length; i++) {
      listOfPolyLineLatLng.add(
        latLng.LatLng(
          listOfCoordinates[i]['latitude'],
          listOfCoordinates[i]['longitude'],
        ),
      );
    }
    Polyline _polyline = Polyline(
        points: listOfPolyLineLatLng, strokeWidth: 3.5, color: Colors.amber);

    return FlutterMap(
      options: MapOptions(
        center: latLng.LatLng(initialLatitude, initialLongitude),
        minZoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/gauti234/ckgovqsac39zk19o5vytzgreo/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZ2F1dGkyMzQiLCJhIjoiY2tnbnA3ZHFvMjNwbzMwdGV1cGVtZWZqciJ9.jO2FxWNXXWh1Q8t_BaNs4g",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoiZ2F1dGkyMzQiLCJhIjoiY2tnbnBlaWE2MHgzbDJ4bzFsb2x5ZnRjaCJ9.W3WKN9f1Uc5v4FT5om3-9g',
          },
        ),
        PolylineLayerOptions(polylines: [_polyline]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final runStatsProvider = Provider.of<RunDataProvider>(context);
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    List<Map<String, double>> listOfLatLng = routeArgs['listOfLatLng'];
    String duration_minutes = routeArgs['duration_minutes'];
    String duration_hours = routeArgs['duration_hours'];
    String duration_seconds = routeArgs['duration_seconds'];
    List<int> time_per_km = routeArgs['time_per_km'] as List<int>;
    List<double> pace_list = pace_calculator(time_per_km);
    List<double> altitude_list = routeArgs['altitude_list'] as List<double>;

    var _isLoading = false;
    // for storing list of Lat Longs in the database

    goToStatsScreen() {
      Map<dynamic, dynamic> toPassToStatsScreen = Map();
      print("time per km is");
      print(time_per_km);
      // List<int> new_time_per_km = time_per_km.sublist(1);
      // List<double> new_speed_per_km = speed_per_km.sublist(1);
      toPassToStatsScreen['pace_list'] = pace_list;
      toPassToStatsScreen['altitude_list'] = altitude_list;
      Navigator.pushNamed(context, Additional_stats.routeName,
          arguments: toPassToStatsScreen);
    }

    double initialLat = routeArgs['initialLat'];
    double initialLong = routeArgs['initialLong'];
    Map<String, dynamic> toPassToPolyLine = {
      'initialLat': initialLat,
      'initialLong': initialLong,
      'listOfLatLng': listOfLatLng,
    };
    double distance = routeArgs['distance'];
    String distanceString = distance.toStringAsFixed(2); // distance in kms
    // final percent = distance * 10;
    DateTime initialTime = routeArgs['initialTime'];
    final String startTime = DateFormat.Hm().format(initialTime);
    final String dateOfRun = initialTime.toIso8601String();
    DateTime finalTime = routeArgs['finalTime'];

    // print(timeSec);
    double allTimeInSec = double.parse(duration_seconds) +
        double.parse(duration_minutes) * 60 +
        double.parse(duration_hours) * 3600;
    double avgSpeed = (distance * 1000) / allTimeInSec;
    double av_pace = ((allTimeInSec / 60.0)) / distance;
    if (distance == 0.0) {
      av_pace = 0.0;
    }
    String av_pace_string = av_pace.toStringAsFixed(2);
    double av_pace_double = double.parse(av_pace_string);
    String show_av_pace_string = "";
    if (av_pace_double.isInfinite || av_pace_double.isNaN) {
      show_av_pace_string = "0:0";
    }
    // Changing the form of av pace
    else {
      show_av_pace_string = (av_pace_double.floor()).toStringAsFixed(0) +
          ":" +
          ((av_pace_double - av_pace_double.floor()) * 60).toStringAsFixed(0);
    }
    // String avgSpeedString = avgSpeed.toStringAsFixed(2);

    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenRatio = (_screenHeight / _screenWidth);
    print(_screenHeight);
    print(_screenRatio);
    final MediaQueryData data = MediaQuery.of(context);

    return MediaQuery(
      data: data.copyWith(textScaleFactor: 0.8),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Color(0xFF93B5C6),
          //centerTitle: true,
          title: InkWell(
            onTap: goToStatsScreen,
            child: Text(
              'SUMMARY',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 0.04 * _screenHeight,
                  fontFamily: 'Gilroy'),
            ),
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                // width: MediaQuery.of(context).size.width,
                height: _screenHeight,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 0.53 * _screenHeight,
                      color: Colors.black,
                      child: createSmallMap(routeArgs),
                    ),
                    Container(
                      height: 0.47 * _screenHeight,
                      width: _screenWidth,
                      decoration: BoxDecoration(
                          // color: Color(0xFF93B5C6),
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(0.05 * _screenHeight),
                          //   topRight: Radius.circular(0.05 * _screenHeight),
                          // ),
                          ),
                      child: Column(
                        children: [
                          Container(
                            height: 0.165 * _screenHeight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 0.025 * _screenWidth,
                                  right: 0.025 * _screenWidth,
                                  top: 0.01 * _screenHeight,
                                  bottom: 0.005 * _screenHeight),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEFEFEF),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(0.015 * _screenHeight),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        duration_hours +
                                            ":" +
                                            duration_minutes +
                                            ":" +
                                            duration_seconds,
                                        style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 0.07 * _screenHeight,
                                            // color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: Center(
                                        child: Text(
                                          'DURATION',
                                          style: TextStyle(
                                              fontSize: 0.018 * _screenHeight,
                                              //      color: Colors.white,
                                              fontFamily: 'Gilroy'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //Divider(height: 0.01 * _screenHeight),
                          // InkWell(
                          //   onTap: () {
                          //     Map pass = Map();
                          //     pass['altitude_list'] = altitude_list;
                          //     pass['pace_list'] = pace_list;
                          //     pass['distance'] = distanceString;
                          //     pass['initialLat'] = initialLat;
                          //     pass['initialLong'] = initialLong;
                          //     pass['listOfLatLng'] = listOfLatLng;
                          //     pass['index'] = -1;

                          //     double max_elevation = 0.0;
                          //     altitude_list.forEach((element) {
                          //       if (element > max_elevation) {
                          //         max_elevation = element;
                          //       }
                          //     });
                          //     pass['max_elevation'] =
                          //         max_elevation.toStringAsFixed(2);
                          //     pass['average_pace'] = show_av_pace_string;
                          //     pass['time'] = duration_hours +
                          //         ':' +
                          //         duration_minutes +
                          //         ':' +
                          //         duration_seconds;

                          //     Navigator.pushNamed(
                          //         context, Additional_stats.routeName,
                          //         arguments: pass);
                          //   },
                          //   child: Container(
                          //     child: Text('Detailed Stats'),
                          //   ),
                          // ),
                          Container(
                            height: 0.165 * _screenHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 0.025 * _screenWidth,
                                    right: 0.0125 * _screenWidth,
                                    top: 0.005 * _screenHeight,
                                    //bottom: 0.01 * _screenHeight
                                  ),
                                  child: Container(
                                    width: 0.45 * _screenWidth,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEFEFEF),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0.015 * _screenHeight),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              "$distanceString",
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontSize:
                                                      0.07 * _screenHeight,
                                                  // color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'KILOMETRES',
                                              style: TextStyle(
                                                  fontSize:
                                                      0.018 * _screenHeight,
                                                  //      color: Colors.white,
                                                  fontFamily: 'Gilroy'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //VerticalDivider(),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 0.025 * _screenWidth,
                                    left: 0.0125 * _screenWidth,
                                    top: 0.005 * _screenHeight,
                                    //bottom: 0.01 * _screenHeight
                                  ),
                                  child: Container(
                                    width: 0.45 * _screenWidth,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEFEFEF),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0.015 * _screenHeight),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              show_av_pace_string,
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontSize:
                                                      0.07 * _screenHeight,
                                                  // color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              'AVG PACE',
                                              style: TextStyle(
                                                  fontSize:
                                                      0.018 * _screenHeight,
                                                  //      color: Colors.white,
                                                  fontFamily: 'Gilroy'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Divider(height: 0.01 * _screenHeight),
                          Container(
                            width: 0.4 * _screenWidth,
                            child: OutlinedButton(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Detailed Stats',
                                      style: TextStyle(
                                          fontFamily: 'Gilroy',
                                          fontSize: 0.025 * _screenHeight,
                                          color: Colors.black),
                                    ),
                                    Icon(
                                      Icons.bar_chart,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () {
                                Map pass = Map();
                                pass['altitude_list'] = altitude_list;
                                pass['pace_list'] = pace_list;
                                pass['distance'] = distanceString;
                                pass['initialLat'] = initialLat;
                                pass['initialLong'] = initialLong;
                                pass['listOfLatLng'] = listOfLatLng;
                                pass['index'] = -1;

                                double max_elevation = 0.0;
                                altitude_list.forEach((element) {
                                  if (element > max_elevation) {
                                    max_elevation = element;
                                  }
                                });
                                pass['max_elevation'] =
                                    max_elevation.toStringAsFixed(2);
                                pass['use_case'] = 'null';
                                pass['average_pace'] = show_av_pace_string;
                                pass['time'] = duration_hours +
                                    ':' +
                                    duration_minutes +
                                    ':' +
                                    duration_seconds;

                                Navigator.pushNamed(
                                    context, Additional_stats.routeName,
                                    arguments: pass);
                              },
                            ),
                          ),

                          // Container(
                          //   child: OutlinedButton(
                          //     onPressed: () {
                          //       Map pass = Map();
                          //       pass['altitude_list'] = altitude_list;
                          //       pass['pace_list'] = pace_list;
                          //       pass['distance'] = distanceString;
                          //       pass['initialLat'] = initialLat;
                          //       pass['initialLong'] = initialLong;
                          //       pass['listOfLatLng'] = listOfLatLng;
                          //       pass['index'] = -1;

                          //       double max_elevation = 0.0;
                          //       altitude_list.forEach((element) {
                          //         if (element > max_elevation) {
                          //           max_elevation = element;
                          //         }
                          //       });
                          //       pass['max_elevation'] =
                          //           max_elevation.toStringAsFixed(2);
                          //       pass['average_pace'] = show_av_pace_string;
                          //       pass['time'] = duration_hours +
                          //           ':' +
                          //           duration_minutes +
                          //           ':' +
                          //           duration_seconds;

                          //       Navigator.pushNamed(
                          //           context, Additional_stats.routeName,
                          //           arguments: pass);
                          //     },
                          //     child: Container(
                          //         width: 0.3 * _screenWidth,
                          //         child: Text('Detailed Stats')),
                          //   ),
                          // ),
                          Expanded(
                            child: Container(
                              // height: 0.08 * _screenHeight,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Add function to add code to database
                                        _isLoading = true;
                                        // SUS - AV PACE STRING IS WRITTEN IN AV SPEED
                                        final activity_name_controller =
                                            TextEditingController();
                                        String is_private = "true";
                                        String activity_name =
                                            Data_Provider().name + " run";
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (ctx) {
                                            print("show dialog initialized");
                                            return Container(
                                              color: Color(0xFFC9CCD5),
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  top: 0.03 * _screenHeight,
                                                  left: 0.03 * _screenWidth,
                                                  right: 0.03 * _screenWidth,
                                                ),
                                                child: Column(
                                                  // title: Text('Workout Description'),
                                                  children: [
                                                    Text(
                                                      'Activity Details',
                                                      textScaleFactor: 0.8,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 0.04 *
                                                              _screenHeight,
                                                          fontFamily: 'Gilroy'),
                                                    ),

                                                    //// TAKING WORKOUT NAME
                                                    Center(
                                                      child: TextField(
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Gilroy'),
                                                        controller:
                                                            activity_name_controller,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Activity Title',
                                                        ),
                                                      ),
                                                      heightFactor: 1,
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 0.05 *
                                                              _screenHeight,
                                                        ),
                                                        Container(
                                                          width: 0.3 *
                                                              _screenWidth,
                                                          child: OutlinedButton(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Public",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      fontSize:
                                                                          0.025 *
                                                                              _screenHeight,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .people_alt_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              ],
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              is_private =
                                                                  "false";
                                                              if (activity_name_controller
                                                                      .text
                                                                      .trim() !=
                                                                  "") {
                                                                activity_name =
                                                                    activity_name_controller
                                                                        .text
                                                                        .trim();
                                                              }
                                                              try {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                print(
                                                                    "came after pop statements");
                                                                await runStatsProvider
                                                                    .addNewRunData(
                                                                  Data_Provider()
                                                                      .name,
                                                                  activity_name,
                                                                  is_private,
                                                                  dateOfRun,
                                                                  av_pace_string,
                                                                  distanceString,
                                                                  startTime,
                                                                  duration_hours,
                                                                  duration_minutes,
                                                                  duration_seconds,
                                                                  listOfLatLng,
                                                                  initialLat,
                                                                  initialLong,
                                                                  pace_list,
                                                                  altitude_list,
                                                                );
                                                                await runStatsProvider
                                                                    .addNewRunDataPublic(
                                                                  Data_Provider()
                                                                      .name,
                                                                  activity_name,
                                                                  is_private,
                                                                  dateOfRun,
                                                                  av_pace_string,
                                                                  distanceString,
                                                                  startTime,
                                                                  duration_hours,
                                                                  duration_minutes,
                                                                  duration_seconds,
                                                                  listOfLatLng,
                                                                  initialLat,
                                                                  initialLong,
                                                                  pace_list,
                                                                  altitude_list,
                                                                );
                                                              } catch (error) {
                                                                showDialog<
                                                                    Null>(
                                                                  context:
                                                                      context,
                                                                  builder: (ctx) =>
                                                                      AlertDialog(
                                                                    title: Text(
                                                                        'An error occured'),
                                                                    content: Text(
                                                                        'Something went wrong'),
                                                                    actions: [
                                                                      FlatButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text('Okay'))
                                                                    ],
                                                                  ),
                                                                );
                                                              }

                                                              setState(() {
                                                                _isLoading =
                                                                    false;
                                                              });
                                                              Navigator
                                                                  .pushReplacementNamed(
                                                                      context,
                                                                      HomeScreen
                                                                          .routeName);
                                                            },
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 0.3 *
                                                              _screenWidth,
                                                          child: OutlinedButton(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Private",
                                                                  textScaleFactor:
                                                                      0.8,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Gilroy',
                                                                      fontSize:
                                                                          0.025 *
                                                                              _screenHeight,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .lock_outline,
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              ],
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              is_private =
                                                                  "true";

                                                              if (activity_name_controller
                                                                      .text
                                                                      .trim() !=
                                                                  "") {
                                                                activity_name =
                                                                    activity_name_controller
                                                                        .text
                                                                        .trim();
                                                              }
                                                              try {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                print(
                                                                    "came after pop statements");
                                                                await runStatsProvider
                                                                    .addNewRunData(
                                                                  Data_Provider()
                                                                      .name,
                                                                  activity_name,
                                                                  is_private,
                                                                  dateOfRun,
                                                                  av_pace_string,
                                                                  distanceString,
                                                                  startTime,
                                                                  duration_hours,
                                                                  duration_minutes,
                                                                  duration_seconds,
                                                                  listOfLatLng,
                                                                  initialLat,
                                                                  initialLong,
                                                                  pace_list,
                                                                  altitude_list,
                                                                );
                                                              } catch (error) {
                                                                showDialog<
                                                                    Null>(
                                                                  context:
                                                                      context,
                                                                  builder: (ctx) =>
                                                                      AlertDialog(
                                                                    title: Text(
                                                                        'An error occured'),
                                                                    content: Text(
                                                                        'Something went wrong'),
                                                                    actions: [
                                                                      FlatButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text('Okay'))
                                                                    ],
                                                                  ),
                                                                );
                                                              }

                                                              setState(() {
                                                                _isLoading =
                                                                    false;
                                                              });
                                                              Navigator
                                                                  .pushReplacementNamed(
                                                                      context,
                                                                      HomeScreen
                                                                          .routeName);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                        // if (activity_name_controller.text
                                        //         .trim() !=
                                        //     "") {
                                        //   activity_name =
                                        //       activity_name_controller.text
                                        //           .trim();
                                        // }

                                        // runStatsProvider
                                        //     .addNewRunData(
                                        //   activity_name,
                                        //   is_private,
                                        //   dateOfRun,
                                        //   av_pace_string,
                                        //   distanceString,
                                        //   startTime,
                                        //   duration_hours,
                                        //   duration_minutes,
                                        //   duration_seconds,
                                        //   listOfLatLng,
                                        //   initialLat,
                                        //   initialLong,
                                        //   pace_list,
                                        //   altitude_list,
                                        // )
                                        //     .catchError((error) {
                                        //   print(error);
                                        //   return showDialog<Null>(
                                        //     context: context,
                                        //     builder: (ctx) => AlertDialog(
                                        //       title: Text('An error occured'),
                                        //       content:
                                        //           Text('Something went wrong'),
                                        //       actions: [
                                        //         FlatButton(
                                        //             onPressed: () {
                                        //               Navigator.of(context)
                                        //                   .pop();
                                        //             },
                                        //             child: Text('Okay'))
                                        //       ],
                                        //     ),
                                        //   );
                                        // }).then(
                                        //   (_) {
                                        //     setState(() {
                                        //       _isLoading = false;
                                        //     });
                                        //     Navigator.pushReplacementNamed(
                                        //         context, HomeScreen.routeName);
                                        //   },
                                        // );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE4D8DC),
                                          // borderRadius: BorderRadius.circular(
                                          //     0.02 * _screenHeight),
                                        ),
                                        alignment: Alignment.center,
                                        width: 0.5 * _screenWidth,
                                        // height: 0.05 * _screenHeight,
                                        child: Text(
                                          'SAVE',
                                          style: TextStyle(
                                              fontSize: 0.04 * _screenHeight,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                            context, HomeScreen.routeName);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFC9CCD5),
                                          // borderRadius: BorderRadius.circular(
                                          //     0.02 * _screenHeight),
                                        ),
                                        alignment: Alignment.center,
                                        width: 0.5 * _screenWidth,
                                        // height: 0.05 * _screenHeight,
                                        child: Text(
                                          'DON\'T SAVE',
                                          style: TextStyle(
                                              fontSize: 0.04 * _screenHeight,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
