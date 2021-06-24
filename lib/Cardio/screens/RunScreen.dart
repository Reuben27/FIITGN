// import 'dart:typed_data';
import 'dart:io';

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
          finishFlag = 1; // flag to check if finish should be showed or no
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
      stopWatchTimer.onExecute.add(StopWatchExecute.start);
      /////%%%%%%%%%%%%%%%%%%%%
      bLoc.BackgroundLocation.getLocationUpdates((location) {
        print("code entered the stream");
        if (_controller != null) {
          // print("stream going on");
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              new CameraPosition(
                  target: LatLng(location.latitude, location.longitude),
                  bearing: 192.232,
                  tilt: 0,
                  zoom: 18.00),
            ),
          );
        }
        updateMarkerAndCircle(location.latitude, location.longitude);
        finalLatitude = location.latitude;
        finalLongitude = location.longitude;
        // if (location.speed <= speedThreshold) {
        // print("speed too slow to count distance");
        // } else {
        distance = distance +
            distanceCovered(initialLatitude, initialLongitude, finalLatitude,
                finalLongitude);
        // }
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
      });
      LatLng latlng = LatLng(initialLatitude, initialLongitude);
      polylineCoordinates.add(latlng);
      _polylines.add(Polyline(
        polylineId: PolylineId(initialLatitude.toString()),
        visible: true,
        //latlng is List<LatLng>
        points: polylineCoordinates,
        color: Colors.blue,
      ));
    } on PlatformException catch (e) {
      print("error");
      print(e.toString());
      if (e.code == 'PERMISSION DENIED') {
        print("Permission Denied");
        debugPrint("Permission Denied");
      }
    }
  }

  void endRun() {}

  _showSnackBar() {
    // print("a");
    final snackBar = SnackBar(content: Text("Sorry! Back button is disabled"));
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).padding.bottom);
    return (
        // height: height,
        // width: width,
        Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        // bottom: PreferredSize(
        //   child: Text(
        //     "SESSIONS CURRENTLY UNDERWAY",
        //     style: TextStyle(fontFamily: 'Gilroy'),
        //   ),
        //   preferredSize: Size.fromHeight(1),
        //   ),
        //   backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'RUNNING',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'Gilroy'),
        ),
      ),
      key: key,
      body: WillPopScope(
        onWillPop: () {
          _showSnackBar();
          return _onBackPressed();
        },
        child: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              height: constraints.maxHeight,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.7,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      initialCameraPosition: initialPosition,
                      mapType: MapType.normal,
                      // markers: Set.of((marker != null) ? [marker] : []),
                      circles: Set.of((circle != null) ? [circle] : []),
                      polylines: _polylines,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              MediaQuery.of(context).size.height / 20),
                          topRight: Radius.circular(
                              MediaQuery.of(context).size.height / 20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height:
                                0.3 * MediaQuery.of(context).size.height / 3,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 0.25 *
                                      MediaQuery.of(context).size.height /
                                      3,
                                  child: StreamBuilder<int>(
                                    stream: stopWatchTimer.rawTime,
                                    initialData: stopWatchTimer.rawTime.value,
                                    builder: (context, snapshot) {
                                      final value = snapshot.data;
                                      final displayTime =
                                          StopWatchTimer.getDisplayTime(value,
                                              hours: isHours,
                                              milliSecond: false);
                                      return Text(
                                        displayTime,
                                        style: TextStyle(
                                            fontFamily: 'Gilroy',
                                            fontSize: 0.15 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            // color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      'DURATION',
                                      style: TextStyle(
                                          //      color: Colors.white,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            height:
                                0.3 * MediaQuery.of(context).size.height / 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 0.25 *
                                            MediaQuery.of(context).size.height /
                                            3,
                                        child: Center(
                                          child: Text(
                                            dist,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontSize: 0.15 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
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
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 0.25 *
                                            MediaQuery.of(context).size.height /
                                            3,
                                        child: Center(
                                          child: Text(
                                            speedString,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontSize: 0.15 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
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
                          Divider(),
                          finishFlag == 0
                              ? Container(
                                  child: InkWell(
                                    // print("%%%%%%%%%%%%%%%%%");
                                    // print("starting the run");
                                    onTap: getCurrentLocation,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green[300],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      child: Text(
                                        'START RUN',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                35,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: InkWell(
                                    // print("%%%%%%%%%%%%%%%%%");
                                    // print("starting the run");
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          var actions2 = [
                                            // ignore: deprecated_member_use
                                            FlatButton(
                                              onPressed: () {
                                                stopWatchTimer.onExecute
                                                    .add(StopWatchExecute.stop);
                                                storeFinalLat = finalLatitude;
                                                storeFinalLong = finalLongitude;
                                                print(distance);
                                                endingTime = DateTime.now();
                                                passingToShowResults[
                                                        'initialLat'] =
                                                    storeInitialLat;
                                                passingToShowResults[
                                                        'initialLong'] =
                                                    storeInitialLong;
                                                passingToShowResults[
                                                    'finalLat'] = storeFinalLat;
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

                                                // print("All parameters stored successfully");

                                                // _locationSubscription.cancel();
                                                bLoc.BackgroundLocation
                                                    .stopLocationService();
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        ShowResultsScreen
                                                            .routeName,
                                                        arguments:
                                                            passingToShowResults);
                                              },
                                              child: Text('Yes'),
                                            ),
                                            // ignore: deprecated_member_use
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop(true);
                                              },
                                              child: Text('No'),
                                            ),
                                          ];
                                          return AlertDialog(
                                            title: Text(
                                                'Are you sure you want to end Run?'),
                                            actions: actions2,
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red[300],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      child: Text(
                                        'END RUN',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                35,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w600),
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
      ),
    ));
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
