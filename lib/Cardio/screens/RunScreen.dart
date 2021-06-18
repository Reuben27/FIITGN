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

class MapScreen extends StatefulWidget {
  static const routeName = 'NewMapScreen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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
        // marker = Marker(
        //   markerId: MarkerId("home"),
        //   visible: false,
        //   position: latlng,
        //   rotation: newLocalData.heading,
        //   draggable: false,
        //   zIndex: 2,
        //   flat: true,
        //   anchor: Offset(0.5, 0.5),
        // );
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
    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%");
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
        print("flag==0 condition");
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
                  // SizedBox(height: MediaQuery.of(context).size.height / 10,),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //       colors: [Color(0xFF145374), Colors.white],
                  //     ),
                  //   ),
                  //   //  color: Colors.black,
                  //   height: MediaQuery.of(context).size.height / 5.5,
                  //   child: Padding(
                  //     padding: EdgeInsets.fromLTRB(
                  //         MediaQuery.of(context).size.width / 20,
                  //         MediaQuery.of(context).size.width / 10,
                  //         0,
                  //         0),
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //             height: MediaQuery.of(context).size.height / 11,
                  //             child: Image.asset('assets/10765.png')),
                  //         SizedBox(
                  //           width: MediaQuery.of(context).size.width / 7,
                  //         ),
                  //         Text(
                  //           'Running',
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontFamily: 'Raleway',
                  //               fontSize: MediaQuery.of(context).size.width / 12),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
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

                  //  Divider(),
                  Expanded(
                    child: Container(
                      child:
                          // child: finishFlag == 1
                          //     ? Container()
                          Column(
                        children: [
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height / 100,
                          // ),
                          // Center(
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         color: Colors.grey,
                          //         borderRadius: BorderRadius.circular(
                          //             MediaQuery.of(context).size.height / 100)),
                          //     height: MediaQuery.of(context).size.height / 500,
                          //     width: MediaQuery.of(context).size.width / 3,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height / 80,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     // Padding(
                          //     //     padding: const EdgeInsets.all(10.0),
                          //     //     child:

                          //     Container(
                          //       child: Text(
                          //         dateToShowOnScreen == null
                          //             ? ''
                          //             : DateFormat.MMMMEEEEd()
                          //                 .format(dateToShowOnScreen)
                          //                 .toString(),
                          //         style: TextStyle(
                          //             //color: Colors.white,
                          //             fontFamily: 'Raleway',
                          //             fontSize:
                          //                 MediaQuery.of(context).size.height /
                          //                     50),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          //  Divider(),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height / 100,
                          // ),
                          Container(
                            height:
                                0.3 * MediaQuery.of(context).size.height / 3,
                            child: Column(
                              children: [
                                // SizedBox(
                                //   width: (3 / 8) *
                                //       (MediaQuery.of(context).size.width),
                                // ),
                                Container(
                                  height: 0.25 *
                                      MediaQuery.of(context).size.height /
                                      3,
                                  //PUT DURATION STOPWATCH HERE
                                  // child: Text(
                                  //   dist,
                                  //   style: TextStyle(
                                  //       // color: Colors.white,
                                  //       fontSize:
                                  //           MediaQuery.of(context).size.height /
                                  //               25,
                                  //       fontWeight: FontWeight.w700),
                                  // ),
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
                                // SizedBox(
                                //   width: (3 / 16) *
                                //       (MediaQuery.of(context).size.width),
                                // ),
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
                                      // SizedBox(
                                      //   width: (3 / 8) *
                                      //       (MediaQuery.of(context).size.width),
                                      // ),
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
                                      // SizedBox(
                                      //   width: (3 / 16) *
                                      //       (MediaQuery.of(context).size.width),
                                      // ),
                                    ],
                                  ),
                                ),
                                VerticalDivider(),
                                // SizedBox(
                                //   width: (3 / 8) *
                                //       (MediaQuery.of(context).size.width),
                                // ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Column(
                                    children: [
                                      // SizedBox(
                                      //   width: (3 / 8) *
                                      //       (MediaQuery.of(context).size.width),
                                      // ),
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
                                      // SizedBox(
                                      //   width: (3 / 16) *
                                      //       (MediaQuery.of(context).size.width),
                                      // ),
                                    ],
                                  ),
                                ),

                                // SizedBox(
                                //   width: (3 / 16) *
                                //       (MediaQuery.of(context).size.width),
                                // ),
                              ],
                            ),
                          ),
                          Divider(),
                          finishFlag == 0
                              ? Expanded(
                                  child: Container(
                                    child: InkWell(
                                      // print("%%%%%%%%%%%%%%%%%");
                                      // print("starting the run");
                                      onTap: getCurrentLocation,
                                      child: IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              //  height:MediaQuery.of(context).size.height/20,
                                              // height: 0.2 * MediaQuery.of(context).size.height / 3 ,

                                              // height:
                                              //     MediaQuery.of(context).size.height /
                                              //         ,
                                              child: Text(
                                                'START RUN',
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            45,
                                                    fontFamily: 'Gilroy',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              // decoration: BoxDecoration(
                                              //     borderRadius:
                                              //         BorderRadius.circular(20),
                                              color: Colors.green[300],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Container(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            var actions2 = [
                                              // ignore: deprecated_member_use
                                              FlatButton(
                                                onPressed: () {
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
                                                  // }
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
                                      child: finishFlag == 0
                                          ? Container()
                                          : Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              // height: MediaQuery.of(context)
                                              //         .size
                                              //         .height /
                                              //     25,
                                              child: Text(
                                                'END RUN',
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            45,
                                                    fontFamily: 'Gilroy',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              // decoration: BoxDecoration(
                                              //     borderRadius:
                                              //         BorderRadius.circular(20),
                                              color: Colors.red[200],
                                            ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(
                      //           MediaQuery.of(context).size.width / 10),
                      //       topRight: Radius.circular(
                      //           MediaQuery.of(context).size.width / 10)),
                      //   color: Colors.grey[850],
                      // ),
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
