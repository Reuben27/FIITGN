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
      // print("Heehahahahahahahah");
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

    var _isLoading = false;
    // for storing list of Lat Longs in the database
    // List<latLng.LatLng> listOfPolyLineLatLng = [];

    // for (int i = 0; i < listOfLatLng.length; i++) {
    //   listOfPolyLineLatLng.add(
    //     latLng.LatLng(
    //       listOfLatLng[i]['latitude'],
    //       listOfLatLng[i]['longitude'],
    //     ),
    //   );

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
    final timeOfRun = finalTime.difference(initialTime);
    String time = timeOfRun.toString();
    List<String> timeList = time.split(':');
    String timeMin = timeList[1];
    String timeHrs = timeList[0];
    String a = timeList[2]; // for conversiom
    double b = double.parse(a); // for conversion
    String timeSec = b.toStringAsFixed(2);
    // print(timeSec);
    double allTimeInSec = double.parse(timeSec) +
        double.parse(timeMin) * 60 +
        double.parse(timeHrs) * 3600;
    double avgSpeed = (distance * 1000) / allTimeInSec;
    String avgSpeedString = avgSpeed.toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        centerTitle: true,
        title: Text(
          'RUN RESULTS',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 1.7,
                    color: Colors.black,
                    child: createSmallMap(routeArgs),
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
                                  child: Text(
                                    timeMin,
                                    style: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 0.15 *
                                            MediaQuery.of(context).size.height /
                                            3,
                                        // color: Colors.white,
                                        fontWeight: FontWeight.w700),
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
                                            "$distanceString",
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
                                            avgSpeedString,
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
                          // finishFlag == 0
                          //     ? Container(
                          //         child: InkWell(
                          //           // print("%%%%%%%%%%%%%%%%%");
                          //           // print("starting the run");
                          //           onTap: getCurrentLocation,
                          //           child: Container(
                          //             decoration: BoxDecoration(
                          //                 color: Colors.green[300],
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             alignment: Alignment.center,
                          //             width: MediaQuery.of(context).size.width /
                          //                 2.5,
                          //             height:
                          //                 MediaQuery.of(context).size.width /
                          //                     10,
                          //             child: Text(
                          //               'START RUN',
                          //               style: TextStyle(
                          //                   fontSize: MediaQuery.of(context)
                          //                           .size
                          //                           .height /
                          //                       35,
                          //                   fontFamily: 'Gilroy',
                          //                   fontWeight: FontWeight.w600),
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     : Container(
                          //         child: InkWell(
                          //           // print("%%%%%%%%%%%%%%%%%");
                          //           // print("starting the run");
                          //           onTap: () {
                          //             showDialog(
                          //               context: context,
                          //               builder: (ctx) {
                          //                 var actions2 = [
                          //                   // ignore: deprecated_member_use
                          //                   FlatButton(
                          //                     onPressed: () {
                          //                       stopWatchTimer.onExecute
                          //                           .add(StopWatchExecute.stop);
                          //                       storeFinalLat = finalLatitude;
                          //                       storeFinalLong = finalLongitude;
                          //                       print(distance);
                          //                       endingTime = DateTime.now();
                          //                       passingToShowResults[
                          //                               'initialLat'] =
                          //                           storeInitialLat;
                          //                       passingToShowResults[
                          //                               'initialLong'] =
                          //                           storeInitialLong;
                          //                       passingToShowResults[
                          //                           'finalLat'] = storeFinalLat;
                          //                       passingToShowResults[
                          //                               'finalLong'] =
                          //                           storeFinalLong;
                          //                       passingToShowResults[
                          //                               'initialTime'] =
                          //                           startingTime;
                          //                       passingToShowResults[
                          //                           'finalTime'] = endingTime;
                          //                       passingToShowResults[
                          //                           'distance'] = distance;
                          //                       passingToShowResults[
                          //                               'listOfLatLng'] =
                          //                           listOfLatLngForPoly;

                          //                       // print("All parameters stored successfully");

                          //                       // _locationSubscription.cancel();
                          //                       bLoc.BackgroundLocation
                          //                           .stopLocationService();
                          //                       Navigator.of(context)
                          //                           .pushReplacementNamed(
                          //                               ShowResultsScreen
                          //                                   .routeName,
                          //                               arguments:
                          //                                   passingToShowResults);
                          //                     },
                          //                     child: Text('Yes'),
                          //                   ),
                          //                   // ignore: deprecated_member_use
                          //                   FlatButton(
                          //                     onPressed: () {
                          //                       Navigator.of(ctx).pop(true);
                          //                     },
                          //                     child: Text('No'),
                          //                   ),
                          //                 ];
                          //                 return AlertDialog(
                          //                   title: Text(
                          //                       'Are you sure you want to end Run?'),
                          //                   actions: actions2,
                          //                 );
                          //               },
                          //             );
                          //           },
                          //           child: Container(
                          //             decoration: BoxDecoration(
                          //                 color: Colors.red[300],
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             alignment: Alignment.center,
                          //             width: MediaQuery.of(context).size.width /
                          //                 2.5,
                          //             height:
                          //                 MediaQuery.of(context).size.width /
                          //                     10,
                          //             child: Text(
                          //               'END RUN',
                          //               style: TextStyle(
                          //                   fontSize: MediaQuery.of(context)
                          //                           .size
                          //                           .height /
                          //                       35,
                          //                   fontFamily: 'Gilroy',
                          //                   fontWeight: FontWeight.w600),
                          //             ),
                          //           ),
                          //         ),
                          //       )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      RaisedButton(
                        onPressed: () async {
                          // Add function to add code to database
                          print(("alpha"));
                          setState(() {
                            _isLoading = true;
                          });
                          print("beta");
                          try {
                            await runStatsProvider.addNewRunData(
                              dateOfRun,
                              avgSpeedString,
                              distanceString,
                              startTime,
                              timeHrs,
                              timeMin,
                              timeSec,
                              listOfLatLng,
                              initialLat,
                              initialLong,
                            );
                            print("function called ");
                          } catch (e) {
                            print("error in saving");
                            print(e);
                            return showDialog<Null>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('An error occured'),
                                content: Text('Something went wrong'),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Okay'))
                                ],
                              ),
                            );
                          }

                          print("gamma");
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName);
                        },
                        elevation: 10,
                        color: Theme.of(context).primaryColor,
                        child: Text('Save Progress'),
                      ),
                      InkWell(
                        onTap: () {
                          // Add function to add code to database
                          _isLoading = true;
                          runStatsProvider
                              .addNewRunData(
                            dateOfRun,
                            avgSpeedString,
                            distanceString,
                            startTime,
                            timeHrs,
                            timeMin,
                            timeSec,
                            listOfLatLng,
                            initialLat,
                            initialLong,
                          )
                              .catchError((error) {
                            print(error);
                            return showDialog<Null>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('An error occured'),
                                content: Text('Something went wrong'),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Okay'))
                                ],
                              ),
                            );
                          }).then(
                            (_) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pushReplacementNamed(
                                  context, HomeScreen.routeName);
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green[300],
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: MediaQuery.of(context).size.width / 10,
                          child: Text(
                            'SAVE PROGRESS',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 35,
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
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: MediaQuery.of(context).size.width / 10,
                          child: Text(
                            "DON'T SAVE",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 35,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
//  Text(
//                      "$distanceString kms",timeMin,avgSpeedString
