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
    if (distance == 0) {
      av_pace = 0.0;
    }
    String av_pace_string = av_pace.toStringAsFixed(2);
    double av_pace_double = double.parse(av_pace_string);
    // Changing the form of av pace
    String show_av_pace_string = (av_pace_double.floor()).toStringAsFixed(0) +
        ":" +
        ((av_pace_double - av_pace_double.floor()) * 60).toStringAsFixed(0);
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
                width: MediaQuery.of(context).size.width,
                height: _screenHeight,
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 0.75 * _screenHeight,
                      color: Colors.black,
                      child: createSmallMap(routeArgs),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 0.34 * _screenHeight,
                        width: _screenWidth,
                        decoration: BoxDecoration(
                          color: Color(0xFF93B5C6),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.05 * _screenHeight),
                            topRight: Radius.circular(0.05 * _screenHeight),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 0.12 * _screenHeight,
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
                            Divider(height: 0.01 * _screenHeight),
                            Container(
                              height: 0.12 * _screenHeight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
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
                                  VerticalDivider(),
                                  Container(
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
                                              'mins/km',
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
                                ],
                              ),
                            ),
                            Divider(height: 0.01 * _screenHeight),
                            Container(
                              height: 0.08 * _screenHeight,
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
                                              color: Color(0xFF93B5C6),
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
                                                                      .people_alt_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              ],
                                                            ),
                                                            onPressed: () {
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

                                                              runStatsProvider
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
                                                              )
                                                                  .catchError(
                                                                      (error) {
                                                                print(error);
                                                                return showDialog<
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
                                                              }).then(
                                                                (_) {
                                                                  setState(() {
                                                                    _isLoading =
                                                                        false;
                                                                  });
                                                                  Navigator.pushReplacementNamed(
                                                                      context,
                                                                      HomeScreen
                                                                          .routeName);
                                                                },
                                                              );
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
                                                            onPressed: () {
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

                                                              runStatsProvider
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
                                                              )
                                                                  .catchError(
                                                                      (error) {
                                                                print(error);
                                                                return showDialog<
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
                                                              }).then(
                                                                (_) {
                                                                  setState(() {
                                                                    _isLoading =
                                                                        false;
                                                                  });
                                                                  Navigator.pushReplacementNamed(
                                                                      context,
                                                                      HomeScreen
                                                                          .routeName);
                                                                },
                                                              );
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
                                          color: Color(0xFF5E8B7E),
                                          borderRadius: BorderRadius.circular(
                                              0.02 * _screenHeight),
                                        ),
                                        alignment: Alignment.center,
                                        width: 0.45 * _screenWidth,
                                        height: 0.05 * _screenHeight,
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
                                          color: Color(0xFFC15050),
                                          borderRadius: BorderRadius.circular(
                                              0.02 * _screenHeight),
                                        ),
                                        alignment: Alignment.center,
                                        width: 0.45 * _screenWidth,
                                        height: 0.05 * _screenHeight,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
//  Text(
//                      "$distanceString kms",timeMin,avgSpeedString
