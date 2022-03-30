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
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  static const routeName = 'NewMapScreen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  final isHours = true;
  bool is_first_run = true;

  @override
  void initState() {
    // TODO: implement initState
    // Obtain shared preferences.
    in_init();

    super.initState();
  }

  void in_init() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('is_first_run')) {
      is_first_run = prefs.getBool('is_first_run');
    }
    // setState(() {});
  }

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
  String pace_string = "0.0";

  String show_av_pace_string = "";

  String current_pace_string = "0:0";
  List<double> altitude_list = [];
  double elevation = 0.0;

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
  double currentKmsCovered = 0.0;
  List<int> timePerKm = []; // in seconds
  // List<double> speedPerKm = []; // in m/s

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  // ignore: non_constant_identifier_names
  generate_community_alert_box(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Location permission"),
      content: Text(
        "To provide a better user experience, FIITGN collects location data to enable fitness tracking even when the app is closed. This data is only used for usage statistics.",
      ),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  pause_run(BuildContext ctx) async {
    print("Pausing RUN");
    await bLoc.BackgroundLocation.stopLocationService();
    // await bLoc.BackgroundLocation.stopLocationService();
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    setState(() {
      resume_end_flag = 1;
    });
    print("run has been paused");
  }

  resume_run(BuildContext ctx) async {
    print("RESUMING RUN");
    // stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    setState(() {
      resume_end_flag = 0;
    });
    start_run(ctx);
  }

  start_run(BuildContext ctx) async {
    // List timeList = displayTime.split(":");
    // int duration_hours_int = int.parse(timeList[0]);
    // int duration_minutes_int = int.parse(timeList[1]);
    // int duration_seconds_int = int.parse(timeList[2]);
    // print("THE TIMES ARE AS FOLLOWS");
    // print(duration_seconds_int);
    // print(duration_minutes_int);
    // print(duration_hours_int);
    // print("starting RUN");

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
    int altitude_flip = 0;
    int setState_counter = 0;
    bLoc.BackgroundLocation.getLocationUpdates(
      (location) {
        altitude_flip += 1;
        print("code entered the BACKGROUND stream");
        if (flip == 0) {
          print("flip reached 0");
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
        } else {
          if (flip == 10) {
            flip = 0;

            print("flip reset");
          } else {
            print("flip counter increased");
            flip += 1;
          }
        }
        if (altitude_flip == 10) {
          print("altitude value changed to -->" + location.altitude.toString());
          altitude_list.add(location.altitude);
          altitude_flip = 0;
        }
        setState_counter += 1;
        if (setState_counter % 4 == 0) {
          elevation = location.altitude;
          setState(() {});
        }
        finalLatitude = location.latitude;
        finalLongitude = location.longitude;
        double av_pace_double = double.parse(pace_string);
        // Changing the form of av pace
        if (av_pace_double.isFinite) {
          show_av_pace_string = (av_pace_double.floor()).toStringAsFixed(0) +
              ":" +
              ((av_pace_double - av_pace_double.floor()) * 60)
                  .toStringAsFixed(0);
        }

        // if (location.speed <= speedThreshold) {
        // print("speed too slow to count distance");
        // } else {

        // adding "if check" to make the initial distance jump go away
        if (distanceCovered(initialLatitude, initialLongitude, finalLatitude, finalLongitude) < 0.1) {
          distance = distance + distanceCovered(initialLatitude, initialLongitude, finalLatitude, finalLongitude);
          if (distance == 0.00) {
            pace_string = "0.0";
          }
          if (distance > currentKmsCovered + 1) {
            print('First km covered');
            if (displayTime != "") {
              List timeList = displayTime.split(":");
              int duration_hours_int = int.parse(timeList[0]);
              int duration_minutes_int = int.parse(timeList[1]);
              int duration_seconds_int = int.parse(timeList[2]);
              int totalTime = duration_seconds_int +
                  duration_minutes_int * 60 +
                  duration_hours_int * 3600;
              if (timePerKm.length > 0) {
                int preceeding_sum = 0;
                for (int time in timePerKm) {
                  preceeding_sum += time;
                }
                int timeForCurrentKm = totalTime - preceeding_sum;
                timePerKm.add(timeForCurrentKm);
                // double speedForCurrentKm =
                //     (1000 + 0.0) / timeForCurrentKm; // speed is in m/s
                // speedPerKm.add(
                //   double.parse(
                //     speedForCurrentKm.toStringAsFixed(2),
                //   ),
                // );
              } else {
                timePerKm.add(totalTime); // total time in seconds is stored
                // should be converted to hrs, mins, secs when displaying using timePerKmcomps()
                // double speedForCurrentKm = (1000 + 0.0) / totalTime;
                // speedPerKm.add(
                //   double.parse(
                //     speedForCurrentKm.toStringAsFixed(2),
                //   ),
                // );
              }
              currentKmsCovered += 1;
            }
          }
        }
        // print("Distance is $dist metres");
        // double speed = location.speed;
        // if (speed > 0.0 && speed.isFinite) {
        //   double current_pace = (1 / speed) * (100 / 6);
        //   current_pace_string = (current_pace.floor()).toStringAsFixed(0) +
        //       ":" +
        //       ((current_pace - current_pace.floor()) * 60).toStringAsFixed(0);
        // } else {
        //   current_pace_string = '0:0';
        // }
        // speedString = speed.toStringAsFixed(1);
        // double pace = (1 / speed) * (100.0 / 6);
        List t_list = displayTime.split(":");
        // List timeList = displayTime.split(":");
        String duration_minutes = t_list[1];
        String duration_hours = t_list[0];
        String duration_seconds = t_list[2];
        int time_in_secs = int.parse(duration_hours) * 3600 +
            int.parse(duration_minutes) * 60 +
            int.parse(duration_seconds);
        double pace = (time_in_secs / 60.0) / distance;
        pace_string = pace.toStringAsFixed(1);
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

  void getCurrentLocation(BuildContext ctx) async {
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
      start_run(ctx);
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
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Color(0xFF93B5C6),
          //centerTitle: true,
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
              pause_run(context);
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
                    height: 0.60 * _screenHeight,
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
                  Container(
                    height: 0.4 * _screenHeight,
                    width: _screenWidth,
                    decoration: BoxDecoration(
                        // color: Color(0xFFC8C6C6),
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(0.05 * _screenHeight),
                        //   topRight: Radius.circular(0.05 * _screenHeight),
                        // ),
                        ),
                    child: Column(
                      children: [
                        Container(
                          height: 0.165 * _screenHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 0.025 * _screenWidth,
                                    right: 0.0125 * _screenWidth,
                                    top: 0.01 * _screenHeight,
                                    bottom: 0.005 * _screenHeight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEFEFEF),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * _screenHeight),
                                    ),
                                  ),
                                  width: 0.45 * _screenWidth,
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
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 0.025 * _screenWidth,
                                    left: 0.0125 * _screenWidth,
                                    top: 0.01 * _screenHeight,
                                    bottom: 0.005 * _screenHeight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEFEFEF),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * _screenHeight),
                                    ),
                                  ),
                                  width: 0.45 * _screenWidth,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Text(
                                            show_av_pace_string,
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
                                            'AVG PACE /km',
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
                            ],
                          ),
                        ),
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
                                    bottom: 0.01 * _screenHeight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEFEFEF),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * _screenHeight),
                                    ),
                                  ),
                                  width: 0.45 * _screenWidth,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: StreamBuilder<int>(
                                          stream: stopWatchTimer.rawTime,
                                          initialData:
                                              stopWatchTimer.rawTime.value,
                                          builder: (context, snapshot) {
                                            final value = snapshot.data;
                                            displayTime =
                                                StopWatchTimer.getDisplayTime(
                                                    value,
                                                    hours: isHours,
                                                    milliSecond: false);
                                            return Text(
                                              displayTime,
                                              style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontSize:
                                                      0.06 * _screenHeight,
                                                  // color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 0.025 * _screenWidth,
                                    left: 0.0125 * _screenWidth,
                                    top: 0.005 * _screenHeight,
                                    bottom: 0.01 * _screenHeight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEFEFEF),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.015 * _screenHeight),
                                    ),
                                  ),
                                  width: 0.45 * _screenWidth,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Text(
                                            elevation.toStringAsFixed(1),
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
                                            'ELEVATION',
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
                            ],
                          ),
                        ),
                        pauseFlag == 0
                            ? Expanded(
                                child: Container(
                                  // height: 0.04 * _screenHeight,
                                  child: Center(
                                    child: Container(
                                      child: InkWell(
                                        // print("%%%%%%%%%%%%%%%%%");
                                        // print("starting the run");
                                        onTap: () async {
                                          if (is_first_run) {
                                            await generate_community_alert_box(
                                                context);
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setBool(
                                                'is_first_run', false);
                                            is_first_run = false;
                                          } else
                                            getCurrentLocation(context);
                                          // getCurrentLocation().then((value) {
                                          //   print("entered run block");
                                          //   start_run();
                                          // });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE4D8DC),
                                            // borderRadius: BorderRadius.circular(
                                            //     0.02 * _screenHeight),
                                          ),
                                          alignment: Alignment.center,
                                          width: _screenWidth,
                                          //height: 0.04 * _screenHeight,
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
                                ),
                              )
                            : pauseFlag == 1 && resume_end_flag == 1
                                ? Expanded(
                                    child: Container(
                                      //  height: 0.08 * _screenHeight,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              child: InkWell(
                                                onTap: () {
                                                  resume_run(context);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFE4D8DC),
                                                    // borderRadius:
                                                    //     BorderRadius.circular(
                                                    //         0.02 * _screenHeight),
                                                  ),
                                                  alignment: Alignment.center,
                                                  width: 0.5 * _screenWidth,
                                                  //  height: 0.05 * _screenHeight,
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
                                                  passingToShowResults[
                                                          'altitude_list'] =
                                                      altitude_list;
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

                                                  // Additional Stats
                                                  passingToShowResults[
                                                          'time_per_km'] =
                                                      timePerKm;
                                                  // passingToShowResults[
                                                  //         'speed_per_km'] =
                                                  //     speedPerKm;
                                                  // print(
                                                  //     "Additional stats testt");
                                                  // print(
                                                  //     "time per kilometer is");
                                                  // print(timePerKm);
                                                  // print(
                                                  //     "and speed per kilometer is");
                                                  // print(speedPerKm);

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
                                                    color: Color(0xFFC9CCD5),
                                                    // borderRadius:
                                                    //     BorderRadius.circular(
                                                    //         0.02 * _screenHeight),
                                                  ),
                                                  alignment: Alignment.center,
                                                  width: 0.5 * _screenWidth,
                                                  // height: 0.05 * _screenHeight,
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
                                    ),
                                  )
                                : Expanded(
                                    child: Container(
                                      //   height: 0.08 * _screenHeight,
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            pause_run(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFC9CCD5),
                                              // borderRadius: BorderRadius.circular(
                                              //     0.02 * _screenHeight),
                                            ),
                                            alignment: Alignment.center,
                                            width: _screenWidth,
                                            //height: 0.05 * _screenHeight,
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
                                    ),
                                  )
                      ],
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
