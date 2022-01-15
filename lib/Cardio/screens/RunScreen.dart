// import 'dart:typed_data';
import 'dart:io';

import 'package:fiitgn/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/services.dart';
import 'dart:math';
import 'ShowRunResults.dart';
import 'package:background_location/background_location.dart' as bLoc;
import 'package:stop_watch_timer/stop_watch_timer.dart';

class MapScreen extends StatefulWidget {
  static const routeName = 'NewMapScreen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  final isHours = true;

  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  int finishFlag = 0; // flag to check if finish should be showed or no
  int pauseFlag = 0;
  int resume_end_flag = 0;
  String displayTime = "";
  bool isChanged = false;
  DateTime startingTime;
  DateTime endingTime;
  double storeInitialLat;
  double storeInitialLong;
  double storeFinalLat;
  double storeFinalLong;
  double initialLatitude;
  double initialLongitude;
  double finalLatitude;
  double finalLongitude;
  DateTime dateToShowOnScreen = DateTime.now();
  List<Map<String, double>> listOfLatLngForPoly = [];
  Map<dynamic, dynamic> passingToShowResults = Map();
  int flag = 0;
  int iter = 1;
  double distance = 0.0;
  double speedThreshold = 1.0;
  int buttonFlag = 0;
  String dist = "";
  String speedString = "";

  StreamSubscription _locationSubscription;
  GoogleMapController _controller;
  loc.Location _locationTracker = loc.Location();
  Marker marker;
  Circle circle;
  // PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  // setting initial Camera Position at Panchayat Circle
  static final CameraPosition initialPosition = CameraPosition(
    target: LatLng(23.210672, 72.684402),
    zoom: 18.00,
  );

  // ADDITIONAL STATS
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  // TIME PER KILOMETER
  // Average speed per kilometer
  int currentKmsCovered = 0;
  List<int> timePerKm = [];
  List<double> speedPerKm = [];

  List<double> timePerKmcomps(double time) {
    double hours = (time + 0.0) % 3600;
    time = time - hours * 3600;
    double mins = (time + 0.0) % 60;
    time = time - mins * 60;
    double secs = time;
    // assert hours>=0 && mins>=0 && secs>=0;
    List<double> ret = [hours, mins, secs];
    return ret;
  }
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  pause_run() async {
    print("Pausing RUN");
    await bLoc.BackgroundLocation.stopLocationService();
    // await bLoc.BackgroundLocation.stopLocationService();
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    setState(() {
      resume_end_flag = 1;
    });
    print("run has been paused");
  }

  resume_run() async {
    print("RESUMING RUN");
    // stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    setState(() {
      resume_end_flag = 0;
    });
    start_run();
  }

  start_run() async {
    print("starting RUN");
    await bLoc.BackgroundLocation.startLocationService();
    if (Platform.isAndroid) {
      await bLoc.BackgroundLocation.setAndroidNotification(
        title: 'FIITGN is running in the background',
        message: 'Please keep the device active',
        icon: "@mipmap/ic_launcher",
      );
    }
    print('BACKGRUND location services started');
    // print("stream beginning");
    ///////%%%%%%%%%%%%%%%%%%
    // STARTING stopwatch
    stopWatchTimer.onExecute.add(StopWatchExecute.start);
    /////%%%%%%%%%%%%%%%%%%%%
    // print("alpha alpha alpha");
    // sampling paramter flip
    int flip = 0;
    bLoc.BackgroundLocation.getLocationUpdates(
      (location) {
        print("code entered the BACKGROUND stream");
        if (flip == 0) {
          print("code inside the flip condition");
          if (_controller != null) {
            // print("stream going on");
            print("animation of camera happening now");
            _controller.animateCamera(
              CameraUpdate.newCameraPosition(
                new CameraPosition(
                    target: LatLng(location.latitude, location.longitude),
                    bearing: 192.232,
                    tilt: 0,
                    zoom: 18.00),
              ),
            );
            updateMarkerAndCircle(location.latitude, location.longitude);
            flip += 1;
          }
        } else{
          if(flip == 10){
            flip = 0;
            print("flip reset");
          }
          else {
            print("flip counter increased");
            flip += 1;
          }
        }

        finalLatitude = location.latitude;
        finalLongitude = location.longitude;
        // if (location.speed <= speedThreshold) {
        // print("speed too slow to count distance");
        // } else {

        // adding "if check" to make the initial distance jump go away
        if (distanceCovered(initialLatitude, initialLongitude, finalLatitude,
                finalLongitude) <
            0.2) {
          distance = distance +
              distanceCovered(initialLatitude, initialLongitude, finalLatitude,
                  finalLongitude);
          if (distance > currentKmsCovered + 1) {
            if (displayTime != "") {
              List timeList = displayTime.split(":");
              int duration_minutes_int = int.parse(timeList[1]);
              int duration_hours_int = int.parse(timeList[0]);
              int duration_seconds_int = int.parse(timeList[2]);
              int totalTime = duration_seconds_int +
                  duration_minutes_int * 60 +
                  duration_hours_int * 3600;
              if (timePerKm.length > 0) {
                int timeForCurrentKm = totalTime - timePerKm.last;
                timePerKm.add(timeForCurrentKm);
                double speedForCurrentKm = (1000 + 0.0) / timeForCurrentKm;
                speedPerKm.add(speedForCurrentKm);
              } else {
                timePerKm.add(totalTime); // total time in seconds is stored
                // should be converted to hrs, mins, secs when displaying using timePerKmcomps()
                double speedForCurrentKm = (1000 + 0.0) / totalTime;
                speedPerKm.add(speedForCurrentKm);
              }
              currentKmsCovered += 1;
            }
          }
        }
        // print("Distance is $dist metres");
        double speed = location.speed;
        speedString = speed.toStringAsFixed(1);

        dist = distance.toStringAsFixed(2);
        initialLatitude = finalLatitude;
        initialLongitude = finalLongitude;
        print("initial Latitude --> " + initialLatitude.toString());
        print("initial Longitude -->" + initialLongitude.toString());
        // listOfLatLngForPoly.add(LatLng(initialLatitude, initialLongitude));
        listOfLatLngForPoly
            .add({'latitude': initialLatitude, 'longitude': initialLongitude});

        // print("beta");
        LatLng latlng = LatLng(initialLatitude, initialLongitude);
        polylineCoordinates.add(latlng);
        _polylines.add(
          Polyline(
            polylineId: PolylineId(initialLatitude.toString()),
            visible: true,
            //latlng is List<LatLng>
            points: polylineCoordinates,
            color: Colors.blue,
          ),
        );
      },
    );
  }

  end_run() {
    print("ENDING RUN");
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    showDialog(
      context: context,
      builder: (ctx) {
        var actions2 = [
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () async {
              // stopWatchTimer.onExecute.add(StopWatchExecute.stop);
              storeFinalLat = finalLatitude;
              storeFinalLong = finalLongitude;
              print(distance);
              endingTime = DateTime.now();
              passingToShowResults['initialLat'] = storeInitialLat;
              passingToShowResults['initialLong'] = storeInitialLong;
              passingToShowResults['finalLat'] = storeFinalLat;
              passingToShowResults['finalLong'] = storeFinalLong;
              passingToShowResults['initialTime'] = startingTime;
              passingToShowResults['finalTime'] = endingTime;
              passingToShowResults['distance'] = distance;
              passingToShowResults['listOfLatLng'] = listOfLatLngForPoly;
              List timeList = displayTime.split(":");
              String duration_minutes = timeList[1];
              String duration_hours = timeList[0];
              String duration_seconds = timeList[2];
              passingToShowResults['duration_minutes'] = duration_minutes;
              passingToShowResults['duration_hours'] = duration_hours;
              passingToShowResults['duration_seconds'] = duration_seconds;

              // print("All parameters stored successfully");

              // _locationSubscription.cancel();
              // await bLoc.BackgroundLocation.stopLocationService();
              Navigator.of(context).pushReplacementNamed(
                  ShowResultsScreen.routeName,
                  arguments: passingToShowResults);
            },
            child: Text('Yes'),
          ),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              stopWatchTimer.onExecute.add(StopWatchExecute.start);
              Navigator.of(ctx).pop(true);
              resume_run();
              // setState(() {
              //   resume_end_flag = 0;
              //   resume_run();
              // });
            },
            child: Text('No'),
          ),
        ];
        return AlertDialog(
          title: Text('Are you sure you want to end Run?'),
          actions: actions2,
        );
      },
    );
  }

  void updateMarkerAndCircle(double latitude, double longitude) {
    // print("newLocalData type is" + newLocalData.runtimeType.toString());
    LatLng latlng = LatLng(latitude, longitude);
    this.setState(
      () {
        circle = Circle(
          circleId: CircleId("_"),
          radius: 2,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70),
        );
      },
    );
  }

  double distanceCovered(double initialLatitude, double initialLongitude,
      double finalLatitude, double finalLongitude) {
    // converting all values to radians
    double lat1 = initialLatitude / 57.29577951;
    initialLongitude = initialLongitude / 57.29577951;
    double lat2 = finalLatitude / 57.29577951;
    finalLongitude = finalLongitude / 57.29577951;
    double dlat = lat2 - lat1;
    double dlon = finalLongitude - initialLongitude;
    // finding distance in Kms using Haversine formula
    double a =
        pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
    double c = 2 * asin(sqrt(a));

    double r = 6371; // radius of Earth in Kms
    double distance = r * c;
    return (distance);
  }

  void getCurrentLocation() async {
    print("RUNNING HAS STARTED");
    try {
      loc.LocationData location = await _locationTracker.getLocation();
      print("location gotten");
      if (Platform.isAndroid) {
        await bLoc.BackgroundLocation.setAndroidNotification(
          title: 'FIITGN is running in the background',
          message: 'Please keep the device active',
          icon: "@mipmap/ic_launcher",
        );
      }
      await bLoc.BackgroundLocation.startLocationService();

      print('location services started');
      updateMarkerAndCircle(location.latitude, location.longitude);
      isChanged = true;
      if (flag == 0) {
        initialLatitude = location.latitude;
        initialLongitude = location.longitude;
        //  storing initial Location
        storeInitialLat = initialLatitude;
        storeInitialLong = initialLongitude;
        setState(() {
          pauseFlag = 1;
          // finishFlag = 1; // flag to check if finish should be showed or no
        });
        listOfLatLngForPoly
            .add({'latitude': storeInitialLat, 'longitude': storeInitialLong});

        startingTime = DateTime.now();
        print("starting Time is " + startingTime.toString());
        // print("This portion is being run");
        flag = 1;
      }
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      // print("stream beginning");

      ///////%%%%%%%%%%%%%%%%%%
      // STARTING stopwatch
      start_run();
    } on PlatformException catch (e) {
      print("error");
      print(e.toString());
      if (e.code == 'PERMISSION DENIED') {
        print("Permission Denied");
        debugPrint("Permission Denied");
      }
    }
  }

  _showSnackBar() {
    // print("a");
    final snackBar = SnackBar(content: Text("Pausing Run"));
    // ignore: deprecated_member_use
    key.currentState.showSnackBar(snackBar);

    // print('b');
  }

  Future<bool> _onBackPressed() {
    return Future<bool>.value(false);
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      // print("Heeheehaa");
      _locationSubscription.cancel();
    }
    // For disposing controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenRatio = (_screenHeight / _screenWidth);
    print(_screenHeight);
    print(_screenRatio);
    final MediaQueryData data = MediaQuery.of(context);
    print(data);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 0.8,
      ),
      child: (Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF93B5C6),
          centerTitle: true,
          title: Text(
            'ACTIVITY LOGGING',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 0.04 * _screenHeight,
                fontFamily: 'Gilroy'),
          ),
        ),
        key: key,
        body: WillPopScope(
          onWillPop: () {
            if (pauseFlag == 0) {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            } else {
              _showSnackBar();
              pause_run();
            }

            // return _onBackPressed();
          },
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              height: _screenHeight,
              child: Column(
                children: [
                  Container(
                    height: 0.66 * _screenHeight,
                    width: _screenWidth,
                    child: GoogleMap(
                      initialCameraPosition: initialPosition,
                      mapType: MapType.normal,
                      // markers: Set.of((marker != null) ? [marker] : []),
                      circles: Set.of((circle != null) ? [circle] : []),
                      // polylines: _polylines,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
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
                                  child: StreamBuilder<int>(
                                    stream: stopWatchTimer.rawTime,
                                    initialData: stopWatchTimer.rawTime.value,
                                    builder: (context, snapshot) {
                                      final value = snapshot.data;
                                      displayTime =
                                          StopWatchTimer.getDisplayTime(value,
                                              hours: isHours,
                                              milliSecond: false);
                                      return Text(
                                        displayTime,
                                        style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 0.07 * _screenHeight,
                                            // color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      );
                                    },
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Text(
                                            dist,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontSize: 0.07 * _screenHeight,
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
                                                fontSize: 0.018 * _screenHeight,
                                                //      color: Colors.white,
                                                fontFamily: 'Gilroy'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                VerticalDivider(
                                  width: 0.08 * _screenHeight,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Text(
                                            speedString,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontSize: 0.07 * _screenHeight,
                                                // color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            'MPS',
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
                              ],
                            ),
                          ),
                          Divider(height: 0.01 * _screenHeight),
                          pauseFlag == 0
                              ? Container(
                                  height: 0.08 * _screenHeight,
                                  child: Center(
                                    child: Container(
                                      child: InkWell(
                                        // print("%%%%%%%%%%%%%%%%%");
                                        // print("starting the run");
                                        onTap: () {
                                          getCurrentLocation();
                                          // getCurrentLocation().then((value) {
                                          //   print("entered run block");
                                          //   start_run();
                                          // });
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
                                            'BEGIN',
                                            style: TextStyle(
                                                fontSize: 0.04 * _screenHeight,
                                                fontFamily: 'Gilroy',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : pauseFlag == 1 && resume_end_flag == 1
                                  ? Container(
                                      height: 0.08 * _screenHeight,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              child: InkWell(
                                                onTap: () {
                                                  resume_run();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF5E8B7E),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.02 *
                                                                _screenHeight),
                                                  ),
                                                  alignment: Alignment.center,
                                                  width: 0.45 * _screenWidth,
                                                  height: 0.05 * _screenHeight,
                                                  child: Text(
                                                    'RESUME',
                                                    style: TextStyle(
                                                        fontSize: 0.04 *
                                                            _screenHeight,
                                                        fontFamily: 'Gilroy',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: InkWell(
                                                onTap: () async {
                                                  stopWatchTimer.onExecute.add(
                                                      StopWatchExecute.stop);
                                                  storeFinalLat = finalLatitude;
                                                  storeFinalLong =
                                                      finalLongitude;
                                                  print(distance);
                                                  endingTime = DateTime.now();
                                                  passingToShowResults[
                                                          'initialLat'] =
                                                      storeInitialLat;
                                                  passingToShowResults[
                                                          'initialLong'] =
                                                      storeInitialLong;
                                                  passingToShowResults[
                                                          'finalLat'] =
                                                      storeFinalLat;
                                                  passingToShowResults[
                                                          'finalLong'] =
                                                      storeFinalLong;
                                                  passingToShowResults[
                                                          'initialTime'] =
                                                      startingTime;
                                                  passingToShowResults[
                                                      'finalTime'] = endingTime;
                                                  passingToShowResults[
                                                      'distance'] = distance;
                                                  passingToShowResults[
                                                          'listOfLatLng'] =
                                                      listOfLatLngForPoly;
                                                  List timeList =
                                                      displayTime.split(":");
                                                  String duration_minutes =
                                                      timeList[1];
                                                  String duration_hours =
                                                      timeList[0];
                                                  String duration_seconds =
                                                      timeList[2];
                                                  passingToShowResults[
                                                          'duration_minutes'] =
                                                      duration_minutes;
                                                  passingToShowResults[
                                                          'duration_hours'] =
                                                      duration_hours;
                                                  passingToShowResults[
                                                          'duration_seconds'] =
                                                      duration_seconds;

                                                  // print("All parameters stored successfully");

                                                  // _locationSubscription.cancel();
                                                  // await bLoc.BackgroundLocation.stopLocationService();
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          ShowResultsScreen
                                                              .routeName,
                                                          arguments:
                                                              passingToShowResults);
                                                  // end_run();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFC15050),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.02 *
                                                                _screenHeight),
                                                  ),
                                                  alignment: Alignment.center,
                                                  width: 0.45 * _screenWidth,
                                                  height: 0.05 * _screenHeight,
                                                  child: Text(
                                                    'FINISH',
                                                    style: TextStyle(
                                                        fontSize: 0.04 *
                                                            _screenHeight,
                                                        fontFamily: 'Gilroy',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 0.08 * _screenHeight,
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            pause_run();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFC15050),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      0.02 * _screenHeight),
                                            ),
                                            alignment: Alignment.center,
                                            width: 0.45 * _screenWidth,
                                            height: 0.05 * _screenHeight,
                                            child: Text(
                                              'PAUSE',
                                              style: TextStyle(
                                                  fontSize:
                                                      0.04 * _screenHeight,
                                                  fontFamily: 'Gilroy',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      )),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color color;
  final String label;
  final Function onPressed;
  CustomButton({this.color, this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      onPressed: onPressed,
      color: color,
      child: Text(label),
    );
  }
}
